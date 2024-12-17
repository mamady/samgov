require 'csv'
require 'open-uri'

class CreateNaicsCodes < ActiveRecord::Migration[7.2]
  def up
    create_table :naics_codes do |t|
      t.string :naics_code, null: false
      t.text :naics_description, null: false

      t.timestamps
    end
    add_index :naics_codes, :naics_code, unique: true

    # Load data from CSV
    csv_url = 'https://raw.githubusercontent.com/fedspendingtransparency/data-act-broker-backend/5e53240a427575780b898f0b91c7bd02ec6b55fb/dataactvalidator/config/naics.csv'
    csv_data = URI.open(csv_url).read
    
    csv = CSV.parse(csv_data, headers: true)
    
    # Process records to remove duplicates
    processed_codes = {}
    csv.each do |row|
      code = row['naics_code']
      next if processed_codes[code] # Skip duplicates
      processed_codes[code] = row['naics_description']
    end

    # Insert records in batches
    processed_codes.each_slice(100) do |batch|
      values = batch.map do |code, description|
        "(#{connection.quote(code)}, #{connection.quote(description)}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)"
      end.join(",\n")
      
      if values.present?
        execute <<-SQL
          INSERT INTO naics_codes (naics_code, naics_description, created_at, updated_at)
          VALUES #{values}
        SQL
      end
    end
  end

  def down
    drop_table :naics_codes
  end
end
