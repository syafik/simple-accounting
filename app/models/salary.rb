class Salary < ActiveRecord::Base # :nodoc:

	belongs_to :salary_history
  belongs_to :salary_history
  attr_accessible :total_attendance, :total_absence, :total_overtime_hours, :total_overtime_payment, :salary_history_id, :date, :jamsostek, :thp, :transfered, :etc, :salary_schedule_id, :potongan, :transport
  validates  :date, presence: true

  scope :this_month, where("MONTH(date) = #{Date.today.month}")

  def self.generate_salary(salary_schedule)
    first_date = salary_schedule.first_date
    end_date = salary_schedule.end_date
    salaries = [] # tamp for salaries
    users = User.all # get all user

    users.each do |user|
      if user.salary_histories.present?
        total_attendance = user.absents.total_attendance_by_date(first_date, end_date).count
        total_absence = user.absents.total_absence_by_date(first_date, end_date).count

        total_overtime_hours = user.overtimes.total_overtime_by_date(first_date, end_date).sum(:long_overtime)
        total_overtime_payment  = user.overtimes.total_overtime_by_date(first_date, end_date).sum(:payment)
        salary_history_id = user.salary_histories.activate.first.id
        jamsostek = 0
        salary_history = user.salary_histories.activate.first
        main_salary = salary_history.payment

        if salary_history.allowed_jamsostek
          jamsostek = main_salary * (Setting[:jamsostek].to_f/100)
        end
        transport = total_attendance*10000
        total_payment = main_salary + total_overtime_payment + jamsostek + transport

        if salary_history.participate_jamsostek
          total_payment = total_payment - jamsostek
        end

        salaries << {
          date: salary_schedule.end_date,
          total_attendance: total_attendance,
          total_absence: total_absence,
          total_overtime_hours: total_overtime_hours,
          total_overtime_payment: total_overtime_payment,
          salary_history_id: salary_history_id,
          jamsostek: jamsostek,
          thp: total_payment,
          transfered: false,
          salary_schedule_id: salary_schedule.id,
          transport: transport
        }

      end
    end

    salary = Salary.create(salaries)
    salary_schedule.update_attribute("status", true) if salary

  end

end

