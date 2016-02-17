
class HomeController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @total_utang =  @user.borrowers.sum(&:credit)
    @total_bayar =  @user.borrowers.sum(&:debit)
    @sisa =  @total_utang - @total_bayar
    @account_receivables = @user.borrowers

        @check_absent = current_user.absents.where({categories: 1, date: Date.today}).first
  end
end
