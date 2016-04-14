
class Api::SalaryHistoriesController < ApplicationController
  skip_before_filter :authenticate_user!, :verify_authenticity_token
  before_filter :authenticate_api
  respond_to :json

## Salary History
  def index
    @salary_histories = SalaryHistory.where(user_id: current_user_api.id).order("created_at DESC")
  end

end
