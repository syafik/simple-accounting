class CreateSalaries < ActiveRecord::Migration
  def change
    create_table :salaries do |t|
      t.date :date
      t.integer :user_id
      t.integer :attendance
      t.integer :number_of_absences
      t.integer :amount_of_overtime

      t.timestamps
    end
  end
end
