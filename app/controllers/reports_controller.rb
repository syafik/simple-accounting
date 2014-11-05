class ReportsController < ApplicationController
  load_and_authorize_resource :class => "Transaction"

  def index
    @year = Date.today.year
    @transactions = TransactionSummary.where(summary_year: @year ).order("summary_month")

    @data =  @transactions.each_with_index.map{|tran, i| {x: "#{Date::MONTHNAMES[tran.summary_month]}-#{tran.summary_year}", y: tran.debit, z: tran.credit, s: tran.debit - tran.credit } }
    @debits = @transactions.sum(:debit) || 0
    @credits = @transactions.sum(:credit) || 0
    @profit = @debits - @credits

  end

end
