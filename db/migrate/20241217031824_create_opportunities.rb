class CreateOpportunities < ActiveRecord::Migration[7.2]
  def change
    create_table :opportunities do |t|
      t.string :noticeId, null: false
      t.string :title
      t.string :solicitationNumber
      t.datetime :postedDate
      t.string :opportunity_type # renamed from type to avoid conflicts with Rails STI
      t.string :naicsCode
      t.string :classificationCode
      t.boolean :active, default: true

      t.timestamps

      t.index :noticeId, unique: true
      t.index :postedDate
      t.index :naicsCode
      t.index :classificationCode
    end
  end
end
