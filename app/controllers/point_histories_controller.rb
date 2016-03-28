
class PointHistoriesController < ApplicationController

  def index
    if current_user.is_admin?
      @histories = PointHistory.this_month
    else
      @histories = PointHistory.this_month.where("user_id = ?", current_user.id)
    end
  end

end
