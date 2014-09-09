class Salary < ActiveRecord::Base

belongs_to :salary_history





  attr_accessible :total_attendance, :total_absence, :total_overtime_hours, :total_overtime_payment, :salary_history_id, :date
  validates  :date,   presence: true

end

