class Transaction < ActiveRecord::Base
  attr_accessible :date, :description, :is_debit, :value
  validates  :date, :description,   presence: true
  validates  :value, presence: true, :numericality => true

  scope :debits, where(:is_debit => true)
  scope :credits, where(:is_debit => false)
  scope :this_month, where(:date => Time.now.beginning_of_month..Time.now.end_of_month)
  scope :next_month, where(:date => Time.now.next_month.beginning_of_month..Time.now.next_month.end_of_month)

  scope :in_last_month, where(:date => 1.month.ago.beginning_of_month..1.month.ago.end_of_month)
  
end
