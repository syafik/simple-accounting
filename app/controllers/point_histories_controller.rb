
class PointHistoriesController < ApplicationController # :nodoc:
  load_and_authorize_resource

  def index
    date = Date.today
    @date = Time.now
    @date = params[:search].to_date if params[:search]
    date1 = @date.beginning_of_month
    date2 = @date.end_of_month
    @rankings = User.joins("left join point_histories on point_histories.user_id = users.id AND point_histories.created_at BETWEEN '#{date1}' AND '#{date2}'").select("users.id,users.first_name, users.last_name, sum(point_histories.points) as jumlah").group("users.id").order("jumlah DESC").where("users.ranked = true")
    @best_employee = BestEmployee.where(date: (date.end_of_month)).first
    @last_best_employee = BestEmployee.where(date: ((date - 1.month).end_of_month)).first
  end

  def my_point
    @date = Date.today
    if params[:search]
      @date = params[:search].to_time
      @histories= PointHistory.where(:created_at => @date.beginning_of_month..@date.end_of_month, :user_id => params[:point_history_id]).order("created_at desc")
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
    @date = params[:search].to_time if params[:search]
    date1 = @date.beginning_of_year
    date2 = @date.end_of_year
    # -- Postgresql code --
    # @rankings = User.joins("left join point_histories on point_histories.user_id = #{params[:point_history_id]} AND point_histories.created_at BETWEEN '#{date1}' AND '#{date2}'").select("users.id,users.first_name, users.last_name, date_trunc('month', point_histories.created_at) as month, sum(point_histories.points) as jumlah").group("users.id,month").order("month asc").where("users.ranked = true")
    # --
    # Mysql code
    @rankings = PointHistory.this_year.where(:user_id => params[:point_history_id]).select("user_id,created_at,sum(points) as jumlah").group("MONTH(created_at)").order("created_at ASC")
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

  def generate_best_employee
    date1 = Time.now.beginning_of_month
    date2 = Time.now.end_of_month
    minimal_point = Point.where(:name => "minimal").first.point
    ranking = User.joins("left join point_histories on point_histories.user_id = users.id AND point_histories.created_at BETWEEN '#{date1}' AND '#{date2}'").select("users.id,users.first_name, users.last_name, sum(point_histories.points) as jumlah").group("users.id").order("jumlah DESC").where("users.ranked = true").having("sum(point_histories.points) >= ?", minimal_point).first
    if ranking.present?
      best_employee = BestEmployee.create(:user_id => ranking.id, :date => Date.today, :total_point => ranking.jumlah, :min_point => minimal_point)
    end
    redirect_to point_histories_path
  end
end
