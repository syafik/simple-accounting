class AddColumOnSalary < ActiveRecord::Migration
  def change
  	add_column :salaries, :jamsostek, :float
  	add_column :salaries, :thp, :float
  end
end
