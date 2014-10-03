class AddTransferedOnSalary < ActiveRecord::Migration
  def change
  	add_column :salaries, :transfered, :boolean
  end
end
