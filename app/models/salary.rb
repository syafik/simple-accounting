class Salary < ActiveRecord::Base

	belongs_to :salary_history

 attr_accessible :total_attendance, :total_absence, :total_overtime_hours, :total_overtime_payment, :salary_history_id, :date
 validates  :date,   presence: true

 def  self.generate_salary
  last_salary = Salary.last
  date = Date.today.at_beginning_of_week.strftime("%Y-%m-2")
  this_mounth = Date.today.at_beginning_of_week.strftime("%m")
  this_year = Date.today.at_beginning_of_week.strftime("%Y")

  if last_salary == nil
      		# get curren date
      		salaries = []
      		
      		p "=========="
      		p date
      		user = User.all

      		user.each do | u |
      			if u.salary_histories
      				total_attendance = Absent.where(:user_id => u, :categories => 1).count
      				total_absence = Absent.where("user_id =? AND categories <> ?", u, 1).count
      				total_overtime_hours = u.overtimes.sum(:long_overtime)
      				total_overtime_payment  = total_overtime_hours * u.overtime_pay
              salary_history_id = u.salary_histories.where(activate: true).select("id").first.id

              salaries << {date: date, total_attendance: total_attendance, total_absence: total_absence,  total_overtime_hours: total_overtime_hours, total_overtime_payment: total_overtime_payment, salary_history_id: salary_history_id }

            end
            @salaries = Salary.new(salaries[0])
            @salaries .save
          end
        else
          if last_salary.date.at_beginning_of_week.strftime("%m") != this_mounth ||  last_salary.date.at_beginning_of_week.strftime("%Y")
          salaries = []
          
          p "=========="
          p date
          user = User.all

          user.each do | u |
            if u.salary_histories
              total_attendance = Absent.where(:user_id => u, :categories => 1).count
              total_absence = Absent.where("user_id =? AND categories <> ?", u, 1).count
              total_overtime_hours = u.overtimes.sum(:long_overtime)
              total_overtime_payment  = total_overtime_hours * u.overtime_pay
              salary_history_id = u.salary_histories.where(activate: true).select("id").first.id

              salaries << {date: date, total_attendance: total_attendance, total_absence: total_absence,  total_overtime_hours: total_overtime_hours, total_overtime_payment: total_overtime_payment, salary_history_id: salary_history_id }

            end
            @salaries = Salary.new(salaries[0])
            @salaries .save
          end
        end
      end

    end

  end

