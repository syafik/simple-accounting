class SalaryHistory < ActiveRecord::Base
	acts_as_paranoid
	belongs_to :user
	has_many :salaries

	scope :activate, -> { where(activate: true) }

	attr_accessible :applicable_date, :payment, :user_id, :activate, :day_payment_overtime, :night_payment_overtime, :allowed_jamsostek, :participate_jamsostek

	validates :payment, presence: true
	validates :day_payment_overtime, presence: true
	validates :night_payment_overtime, presence: true
	validates :applicable_date, presence: true
   # validates :activate, presence: true


 end

