class AddStatusAndGeneratedDateToSalarySchedules < ActiveRecord::Migration
  def change
    add_column :salary_schedules, :status, :boolean, default: false
    add_column :salary_schedules, :first_date, :date
    add_column :salary_schedules, :end_date, :date
  end
end
