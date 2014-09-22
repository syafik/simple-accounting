class OvertimePaymentHistory < ActiveRecord::Base
	acts_as_paranoid
	belongs_to :user
	attr_accessible :activate, :day_payment, :night_payment, :applicable_date, :user_id

	validates :day_payment, presence: true
	validates :night_payment, presence: true
	validates :applicable_date, presence: true
end
