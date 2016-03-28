
class PointHistoriesController < ApplicationController

  def index
    @date = Date.today
    if params[:search]
      @date = params[:search].to_date
      if current_user.is_admin?
        @histories= PointHistory.where(:created_at => @date.beginning_of_month..@date.end_of_month)
      else
        @histories= PointHistory.where(:created_at => @date.beginning_of_month..@date.end_of_month, :user_id => current_user.id)
      end
    else
       if current_user.is_admin?
        @histories= PointHistory.this_month
      else
        @histories= PointHistory.this_month.where(:user_id => current_user.id)
      end
    end
  end

end
