class ReportsController < ApplicationController
  load_and_authorize_resource :class => "Transaction"

  def index
    @year = Date.today.year
    @transactions = TransactionSummary.get_report(@year )
    # @debits = @transactions[4].sum(:debit) || 0
    @debits = @transactions[4].map(&:debit).inject(0, &:+) || 0
    @credits =@transactions[4].map(&:credit).inject(0, &:+) || 0
    @profit = @transactions[4].map(&:total).inject(0, &:+) || 0

  end

end
