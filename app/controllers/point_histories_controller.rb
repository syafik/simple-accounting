
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

  def ranking
    @date = Time.now
    @date = params[:search].to_date if params[:search]
    date1 = @date.beginning_of_month
    date2 = @date.end_of_month
    @rankings = User.joins("left join point_histories on point_histories.user_id = users.id AND point_histories.created_at BETWEEN '#{date1}' AND '#{date2}'").select("users.first_name, users.last_name, sum(point_histories.points) as jumlah").group("users.id").order("jumlah DESC")
  end
end
