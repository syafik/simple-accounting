class RenameDateFromSalaryHistory < ActiveRecord::Migration
  def change
  	rename_column :salary_histories, :date, :applicable_date
  end
end
