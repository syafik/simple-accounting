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
  # {
  #   "month_point": 2,
  #   "year_point": 9,
  #   "point_histories": [
  #     {
  #       "created_at": "2016-04-08T09:45:30+07:00",
  #       "id": 4,
  #       "point_historyable_id": 9,
  #       "point_historyable_type": "Absent",
  #       "point_id": 1,
  #       "points": 2,
  #       "updated_at": "2016-04-08T09:45:30+07:00",
  #       "user_id": 1
  #     }
  #   ]
  # }
  def index
    @histories= PointHistory.this_month.where(:user_id => current_user_api).order("created_at DESC")
    @yearpoints= PointHistory.this_year.where(:user_id => current_user_api)
  end

end
