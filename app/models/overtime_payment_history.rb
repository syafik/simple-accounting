class OvertimePaymentHistory < ActiveRecord::Base
  belongs_to :user
  attr_accessible :activate, :day_payment, :night_payment, :applicable_date, :user_id
end
