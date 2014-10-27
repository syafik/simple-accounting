class ReportsController < ApplicationController
  load_and_authorize_resource :class => "Transaction"

  def index
    @year = Date.today.year
    @transactions = Transaction.by_year(@year)

    data = []
    (1..12).each do |i|
      transaction = @transactions.by_month(i)
      data << {x: "#{@year}-#{i}", y: transaction.debits.sum(:value), z: transaction.credits.sum(:value), s: (transaction.debits.sum(:value) - transaction.credits.sum(:value)) }
    end
    @data = data
    @debits = @transactions.debits.sum(:value) || 0
    @credits = @transactions.credits.sum(:value) || 0
    @profit = @debits - @credits

    #@transactions = Transaction.by_year(year).group("Extract(MONTH FROM date), is_debit").
    #    select("CASE WHEN is_debit THEN sum(value) END as debit, CASE WHEN !is_debit THEN sum(value) END as credit, sum(value), EXTRACT(MONTH from date) as bulan, is_debit")
  end

end
