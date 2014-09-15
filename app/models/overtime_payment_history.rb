class OvertimePaymentHistory < ActiveRecord::Base
  belongs_to :user
  attr_accessible :activate, :date, :date, :day_payment, :night_payment
end
