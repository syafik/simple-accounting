class CreateSalarySchedules < ActiveRecord::Migration
  def change
    create_table :salary_schedules do |t|
      t.date :date

      t.timestamps
    end
  end
end
