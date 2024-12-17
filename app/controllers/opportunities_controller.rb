class OpportunitiesController < ApplicationController
  def index
    # only where naics_code starts with 541
    @opportunities = Opportunity.includes(:naics_code)
                              .where('naicsCode LIKE ?', '541%')
                              .order(postedDate: :desc)
  end
end