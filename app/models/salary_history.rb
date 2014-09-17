class SalaryHistory < ActiveRecord::Base
  belongs_to :user
  has_many :salaries
  attr_accessible :date, :payment, :user_id, :activate

   validates :payment, presence: true
   # validates :date, presence: true
   # validates :activate, presence: true


end
