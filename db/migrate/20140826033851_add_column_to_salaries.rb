class AddColumnToSalaries < ActiveRecord::Migration
  def change
  	add_column :salaries, :salary, :float
  	add_column :salaries, :overtime_pay, :float  
  end
end
