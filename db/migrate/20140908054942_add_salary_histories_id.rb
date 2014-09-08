class AddSalaryHistoriesId < ActiveRecord::Migration
  def change
  	add_column :salaries, :salary_history_id, :integer
  end
end
