class Salary < ActiveRecord::Base

#belongs_to :user 





  attr_accessible :amount_of_overtime, :attendance, :date, :number_of_absences, :user_id, :salary, :overtime_pay
  validates  :date,   presence: true

end

