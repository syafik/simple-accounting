class Api::PointsController < ApplicationController
  skip_before_filter :authenticate_user!, :verify_authenticity_token
  before_filter :authenticate_api
  respond_to :json

## Point List
  def index
    @histories= PointHistory.this_month.where(:user_id => current_user_api).order("created_at DESC")
    @yearpoints= PointHistory.this_year.where(:user_id => current_user_api)
  end

end
