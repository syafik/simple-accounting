class SalaryHistory < ActiveRecord::Base
	acts_as_paranoid
	belongs_to :user
	has_many :salaries
	attr_accessible :applicable_date, :payment, :user_id, :activate

	validates :payment, presence: true
	validates :applicable_date, presence: true
   # validates :activate, presence: true


 end
