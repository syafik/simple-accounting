
class PointHistoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @date = Time.now
    @date = params[:search].to_date if params[:search]
    date1 = @date.beginning_of_month
    date2 = @date.end_of_month
    @rankings = User.joins("left join point_histories on point_histories.user_id = users.id AND point_histories.created_at BETWEEN '#{date1}' AND '#{date2}'").select("users.id,users.first_name, users.last_name, sum(point_histories.points) as jumlah").group("users.id").order("jumlah DESC").where("users.ranked = true")
  end

  def my_point
    @date = Date.today
    if params[:search]
      @date = params[:search].to_date
      @histories= PointHistory.where(:created_at => @date.beginning_of_month..@date.end_of_month, :user_id => params[:point_history_id])
      @yearpoints= PointHistory.where(:created_at => @date.beginning_of_year..@date.end_of_year, :user_id => params[:point_history_id])
    else
        @histories= PointHistory.this_month.where(:user_id => params[:point_history_id])
        @yearpoints= PointHistory.this_year.where(:user_id => params[:point_history_id])
    end
  end

  def year_ranking
    @date = Time.now
    @date = params[:search].to_date if params[:search]
    date1 = @date.beginning_of_year
    date2 = @date.end_of_year
    @rankings = User.joins("left join point_histories on point_histories.user_id = users.id AND point_histories.created_at BETWEEN '#{date1}' AND '#{date2}'").select("users.id,users.first_name, users.last_name, sum(point_histories.points) as jumlah").group("users.id").order("jumlah DESC").where("users.ranked = true")
  end

  def detail_year
    @date = Time.now
    @date = params[:search].to_date if params[:search]
    date1 = @date.beginning_of_year
    date2 = @date.end_of_year
    # -- Postgresql code --
    # @rankings = User.joins("left join point_histories on point_histories.user_id = #{params[:point_history_id]} AND point_histories.created_at BETWEEN '#{date1}' AND '#{date2}'").select("users.id,users.first_name, users.last_name, date_trunc('month', point_histories.created_at) as month, sum(point_histories.points) as jumlah").group("users.id,month").order("month asc").where("users.ranked = true")
    # --
    # Mysql code
    @rankings = User.joins("left join point_histories on point_histories.user_id = #{params[:point_history_id]} AND point_histories.created_at BETWEEN '#{date1}' AND '#{date2}'").select("users.id,users.first_name, users.last_name, point_histories.created_at, sum(point_histories.points) as jumlah").group("users.id,MONTH(point_histories.created_at)").order("MONTH(point_histories.created_at) asc").where("users.ranked = true")
  end

  def ranking_status
    @users = User.all
  end

  def change_ranking_status
    user = User.find(params[:id])
    if user.ranked == true
      user.ranked = false
    else
      user.ranked = true
    end
    user.save
    redirect_to ranking_status_point_histories_path
  end

end
