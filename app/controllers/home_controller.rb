
class HomeController < ApplicationController # :nodoc:
  def index
    @user = User.find(current_user.id)
    @total_utang =  @user.borrowers.sum(&:credit)
    @total_bayar =  @user.borrowers.sum(&:debit)
    @sisa =  @total_utang - @total_bayar
    if Date.today == Date.today.end_of_month
        @best_employee = BestEmployee.this_month.first
    else
        @best_employee = BestEmployee.last_month.first
    end
    @check_absent = current_user.absents.where({categories: 1, date: Date.current}).first
    date = Date.current
    year = date.year
    month = date.month
    @absent = User.joins("left join absents on absents.user_id = users.id AND MONTH(absents.date) = #{month} AND YEAR(absents.date) =  #{year}").
    select("users.first_name, users.last_name, count(absents.user_id) as jumlah ").where(id: current_user.id).group("absents.user_id").first rescue nil

  end
end
