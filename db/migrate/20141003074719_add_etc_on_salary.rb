class AddEtcOnSalary < ActiveRecord::Migration
  def change
  	add_column :salaries, :etc, :float
  end
end
