class TransactionSummary < ActiveRecord::Base
  attr_accessible :credit, :debit, :description, :name, :total, :summary_month, :summary_year


  before_validation :calculate_total
  after_save :update_status_transactions

  def update_status_transactions
    date = DateTime.new(self.summary_year.to_i, self.summary_month.to_i, 1)
    start_date = date.beginning_of_month
    end_date = date.end_of_month
    transactions = Transaction.where(created_at: start_date..end_date).update_all(:is_close => true)
  end

  def calculate_total
    self.total = self.debit - self.credit rescue nil
  end

  def self.calculate_per_month(month, year)
    date = DateTime.new(year.to_i, month.to_i, 1)
    start_date = date.beginning_of_month
    end_date = date.end_of_month
    transactions = Transaction.where(created_at: start_date..end_date).group("is_debit").select("sum(value) as jumlah, is_debit")
    result = {}
    result[:summary_month] = month
    result[:summary_year] = year
    result[:debit] = 0
    result[:credit] = 0
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
    ts = TransactionSummary.where(summary_year: result[:summary_year], summary_month: result[:summary_month])
    if ts.empty?
      transaction_summary = new(result)
      transaction_summary.save
    else
      $stdout.puts ts.inspect
      $stdout.puts ts.first.inspect
      ts.first.update_attributes(result)
      $stdout.puts ts.first.inspect
    end
  end

  def self.get_report(summary_year= Date.today.year)
    data = self.select("sum(debit) as debit , sum(credit) as credit, sum(total) as total, summary_month, summary_year").
        where(summary_year: summary_year).
        group("summary_month, summary_year").
        order("summary_month ASC")
    debit = []
    credit = []
    selisih = []
    kas_total = []
    kas = 0
    list = data.collect { |s| s.summary_month }
    (1..12).each do |i|
      if c = list.index(i)
        kas = kas + data[c].total

        debit << data[c].debit
        credit << data[c].credit
        selisih << data[c].total
        kas_total << kas
      else
        debit << 0
        credit << 0
        selisih << 0
        kas_total << kas
      end
    end
    return debit, credit, selisih, kas_total, data
  end
end
