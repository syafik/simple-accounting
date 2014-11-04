class TransactionSummary < ActiveRecord::Base
  attr_accessible :credit, :debit, :description, :name, :total,  :summary_month, :summary_year


  before_validation :calculate_total
  after_save :update_status_transactions

  def update_status_transactions
    date = DateTime.new(self.summary_year.to_i, self.summary_month.to_i, 1)
    start_date = date.beginning_of_month
    end_date = date.end_of_month
    transactions = Transaction.where(date: start_date..end_date).update_all(:is_close => true)
  end

  def calculate_total
    self.total = self.debit - self.credit rescue nil
  end

  def self.calculate_per_month(month, year)
    date = DateTime.new(year.to_i, month.to_i, 1)
    start_date = date.beginning_of_month
    end_date = date.end_of_month
    transactions = Transaction.where(date: start_date..end_date).group("is_debit").select("sum(value) as jumlah, is_debit")
    result = {}
    result[:summary_month] = month
    result[:summary_year] = year
    result[:debit] = 0
    result[:debit] = 0
    transactions.each do |transaction|
      if transaction.is_debit
        result[:debit] = transaction.jumlah
      else
        result[:credit] = transaction.jumlah
      end
    end
    create_close_book(result)
  end

  def self.create_close_book(result)
    transaction_summary =  new(result)
    transaction_summary.save
  end

end
