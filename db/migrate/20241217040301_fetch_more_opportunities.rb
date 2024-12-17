require 'httparty'
require 'date'

class FetchMoreOpportunities < ActiveRecord::Migration[7.2]
  def up
    # api_key = ENV['SAM_GOV_API_KEY'] || '7vdUE77yDko0fi3xa2pVQcdxWdfKhtQzhYu1USIl'
    
    # # Format dates for the API
    # posted_from = Date.today.beginning_of_year.strftime('%m/%d/%Y')
    # posted_to = Date.today.end_of_year.strftime('%m/%d/%Y')
    
    # base_url = "https://api.sam.gov/opportunities/v2/search"
    # opportunities_per_page = 10
    # total_pages = 5  # Reduced number of pages to avoid rate limits
    # base_delay = 10  # Base delay between requests in seconds
    
    # (0...total_pages).each do |page|
    #   offset = page * opportunities_per_page
    #   max_retries = 3
    #   success = false
      
    #   max_retries.times do |retry_count|
    #     puts "Fetching page #{page + 1} of #{total_pages}..."
        
    #     response = HTTParty.get(base_url, query: {
    #       limit: opportunities_per_page,
    #       offset: offset,
    #       api_key: api_key,
    #       postedFrom: posted_from,
    #       postedTo: posted_to,
    #       ptype: 'o,k'
    #     })

    #     if response.code == 429
    #       wait_time = base_delay * (2 ** (retry_count + 1))  # Exponential backoff
    #       puts "Rate limit hit. Waiting #{wait_time} seconds before retry #{retry_count + 1}/#{max_retries}..."
    #       sleep(wait_time)
    #       next
    #     end

    #     if response.success?
    #       success = true
    #       opportunities = response.parsed_response['opportunitiesData']
          
    #       opportunities.each do |opp|
    #         # Use execute to perform raw SQL insert with conflict handling
    #         execute <<-SQL
    #           INSERT INTO opportunities (
    #             noticeId, title, solicitationNumber, postedDate, 
    #             opportunity_type, naicsCode, classificationCode, active,
    #             created_at, updated_at
    #           )
    #           VALUES (
    #             #{quote(opp['noticeId'])},
    #             #{quote(opp['title'])},
    #             #{quote(opp['solicitationNumber'])},
    #             #{quote(opp['postedDate'] ? Time.parse(opp['postedDate']).utc : nil)},
    #             #{quote(opp['type'])},
    #             #{quote(opp['naicsCode'])},
    #             #{quote(opp['classificationCode'])},
    #             #{quote(!!opp['active'])},
    #             CURRENT_TIMESTAMP,
    #             CURRENT_TIMESTAMP
    #           )
    #           ON CONFLICT (noticeId) DO UPDATE SET
    #             title = #{quote(opp['title'])},
    #             solicitationNumber = #{quote(opp['solicitationNumber'])},
    #             postedDate = #{quote(opp['postedDate'] ? Time.parse(opp['postedDate']).utc : nil)},
    #             opportunity_type = #{quote(opp['type'])},
    #             naicsCode = #{quote(opp['naicsCode'])},
    #             classificationCode = #{quote(opp['classificationCode'])},
    #             active = #{quote(!!opp['active'])},
    #             updated_at = CURRENT_TIMESTAMP
    #         SQL
            
    #         print "."
    #       end
    #       puts " Done!"
          
    #       # Sleep to avoid hitting rate limits
    #       sleep(base_delay)  # Base delay between successful requests
    #       break  # Exit retry loop on success
    #     else
    #       puts "Error fetching page #{page + 1}: #{response.code} - #{response.message}"
    #     end
    #   rescue StandardError => e
    #     puts "Error on page #{page + 1}: #{e.message}"
    #   end
    # end
  end

  def down
    # This migration cannot be reversed
  end

  private

  def quote(value)
    value.nil? ? 'NULL' : ActiveRecord::Base.connection.quote(value)
  end
end
