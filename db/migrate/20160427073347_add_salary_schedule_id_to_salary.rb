class AddSalaryScheduleIdToSalary < ActiveRecord::Migration
  def change
    add_column :salaries, :salary_schedule_id, :integer, default: 0
    add_column :salaries, :transport, :integer, default: 0
    add_column :salaries, :potongan, :integer, default: 0
  end
end
