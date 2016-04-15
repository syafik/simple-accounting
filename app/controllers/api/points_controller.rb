class Api::PointsController < Api::ApiController
  skip_before_filter :authenticate_user!, :verify_authenticity_token
  before_filter :authenticate_api
  respond_to :json

  ##
  # ::Point
  # ===Point
  # method:
  #   GET
  # url:
  #   /api/points
  # header:
  #   content-type: application/json
  #   authorization:Token token= authtentication_token
  # response:
  # * success
  #  {
  #   "month_point":11,
  #   "year_point":11,
  #   "point_histories":[]
  #   }
  def index
    @histories= PointHistory.this_month.where(:user_id => current_user_api).order("created_at DESC")
    @yearpoints= PointHistory.this_year.where(:user_id => current_user_api)
  end

end
