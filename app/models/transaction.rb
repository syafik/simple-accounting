class Transaction < ActiveRecord::Base # :nodoc:

  belongs_to :account_receivable
  belongs_to :account_payable

  attr_accessible :date, :description, :is_debit, :value, :is_close
  validates :date, :description, presence: true
  validates :value, presence: true, :numericality => true

  scope :debits, where(:is_debit => true)
  scope :credits, where(:is_debit => false)
  scope :this_month, where(:date => Time.now.beginning_of_month..Time.now.end_of_month)
  scope :next_month, where(:date => Time.now.next_month.beginning_of_month..Time.now.next_month.end_of_month)

  scope :in_last_month, where(:date => 1.month.ago.beginning_of_month..1.month.ago.end_of_month)

  scope :by_year, (lambda do |year|
    dt = DateTime.new(year.to_i, 1, 1)
    boy = dt.beginning_of_year
    eoy = dt.end_of_year
    where("date >= ? and date <= ?", boy, eoy)
  end)

  scope :by_month, (lambda do |month|
    where("MONTH(date) = #{month}")
  end)
end
