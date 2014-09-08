class RenameFieldSalaries < ActiveRecord::Migration
  def change
  	rename_column :salaries, :attendance, :total_attendance
  	rename_column :salaries, :number_of_absences, :total_absence
  	rename_column :salaries, :amount_of_overtime, :total_overtime_hours
  	rename_column :salaries, :overtime_pay, :total_overtime_payment
  end
end
