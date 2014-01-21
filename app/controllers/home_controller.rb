
class HomeController < ApplicationController
  def index

    @current_time = Date.today
    year = params[:year] || @current_time.year
    month = params[:month] || @current_time.month
    day = params[:day] || @current_time.day #9
    @date = DateTime.new(year.to_i,month.to_i, 1)
    @next = @date + 1.month
    @prev = @date - 1.month
    @start_date = @date.beginning_of_month
    @end_date = @date.end_of_month
   @transactions = Transaction.where(:date => @start_date..@end_date).order('date ASC')
    @total_debit = @transactions.debits.sum(:value)
    @total_credit = @transactions.credits.sum(:value)
    @profit = @total_debit -  @total_credit
  end
end
