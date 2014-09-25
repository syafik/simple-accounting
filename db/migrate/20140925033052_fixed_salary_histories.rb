class FixedSalaryHistories < ActiveRecord::Migration
  def change
  	add_column :salary_histories, :day_payment_overtime, :float
  	add_column :salary_histories, :night_payment_overtime, :float
  end
end
