class OpportunitiesController < ApplicationController
  def index
    @opportunities = Opportunity.includes(:naics_code)
                              .order(postedDate: :desc)
  end
end