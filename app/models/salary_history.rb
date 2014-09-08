class SalaryHistory < ActiveRecord::Base
  #belongs_to :user
  attr_accessible :date, :payment, :user_id


end
