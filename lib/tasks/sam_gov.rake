namespace :sam_gov do
  desc 'Fetch opportunities from SAM.gov API'
  task fetch_opportunities: :environment do
    require 'httparty'
    require 'date'

    api_key = ENV['SAM_GOV_API_KEY']
    
    # Format dates for the API
    posted_from = Date.today.beginning_of_year.strftime('%m/%d/%Y')
    posted_to = Date.today.end_of_year.strftime('%m/%d/%Y')
    
    url = "https://api.sam.gov/opportunities/v2/search"
    
    begin
      response = HTTParty.get(url, query: {
        limit: 1000,
        api_key: api_key,
        postedFrom: posted_from,
        postedTo: posted_to,
        ptype: 'o,k'
      })

      if response.success?
        opportunities = response.parsed_response['opportunitiesData']
        
        opportunities.each do |opp|
          Opportunity.find_or_initialize_by(noticeId: opp['noticeId']).tap do |opportunity|
            opportunity.assign_attributes(
              title: opp['title'],
              solicitationNumber: opp['solicitationNumber'],
              postedDate: Time.parse(opp['postedDate']),
              opportunity_type: opp['type'],
              naicsCode: opp['naicsCode'],
              classificationCode: opp['classificationCode'],
              active: opp['active']
            )
            
            if opportunity.changed?
              if opportunity.save
                puts "Successfully saved opportunity: #{opportunity.noticeId}"
              else
                puts "Error saving opportunity #{opportunity.noticeId}: #{opportunity.errors.full_messages.join(', ')}"
              end
            else
              puts "No changes for opportunity: #{opportunity.noticeId}"
            end
          end
        end
        
        puts "\nProcessed #{opportunities.size} opportunities"
      else
        puts "Error fetching opportunities: #{response.code} - #{response.message}"
      end
    rescue StandardError => e
      puts "Error: #{e.message}"
    end
  end
end