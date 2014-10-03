class Salary < ActiveRecord::Base

	belongs_to :salary_history

 attr_accessible :total_attendance, :total_absence, :total_overtime_hours, :total_overtime_payment, :salary_history_id, :date
 validates  :date,   presence: true

 def  self.generate_salary
  last_salary = Salary.last
  date = Date.today.strftime("%Y-%m-2")
  this_month = Date.today.month
  this_year = Date.today.year


  salaries = [] # tamp for salaries

  user = User.all # get all user


  user.each do | u |
    if u.role.name != "admin" && u.salary_histories
      total_attendance = Absent.where(:user_id => u, :categories => 1).count
      total_absence = Absent.where("user_id =? AND categories <> ?", u, 1).count
      total_overtime_hours = u.overtimes.where("user_id = ? AND status = ? AND extract(month  from date) = ?", u.id, true, this_month).sum(:long_overtime)
      total_overtime_payment  = u.overtimes.where("user_id = ? AND status = ? AND extract(month  from date) = ?", u.id, true, this_month).sum(:payment)
      salary_history_id = u.salary_histories.activate.first.id
      salaries << {date: date, total_attendance: total_attendance, total_absence: total_absence,  total_overtime_hours: total_overtime_hours, total_overtime_payment: total_overtime_payment, salary_history_id: salary_history_id }

    end
  end

  if last_salary == nil || last_salary.date.month != this_month || last_salary.date.year != this_year
    Salary.create(salaries)
  end
end

end

