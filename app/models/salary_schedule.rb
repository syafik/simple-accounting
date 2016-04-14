class SalarySchedule < ActiveRecord::Base # :nodoc:
  attr_accessible :date, :first_date, :end_date

  scope :this_year, where("YEAR(date) = #{Date.today.year}")
  scope :this_month, where("MONTH(date) = #{Date.today.month}")
  scope :prev_month, where("MONTH(date) = #{Date.today.month - 1.month}")

end
