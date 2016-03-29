
class HomeController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @total_utang =  @user.borrowers.sum(&:credit)
    @total_bayar =  @user.borrowers.sum(&:debit)
    @sisa =  @total_utang - @total_bayar

    @check_absent = current_user.absents.where({categories: 1, date: Date.today}).first
    date = Date.today
    year = date.year
    month = date.month
    @absent = User.joins("left join absents on absents.user_id = users.id AND MONTH(absents.date) = #{month} AND YEAR(absents.date) =  #{year}").
    select("users.first_name, users.last_name, count(absents.user_id) as jumlah ").where(id: current_user.id).group("absents.user_id").first rescue nil

  end
end
