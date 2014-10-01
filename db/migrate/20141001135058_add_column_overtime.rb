class AddColumnOvertime < ActiveRecord::Migration
  def change
  	add_column :overtimes, :day_payment, :float
  	add_column :overtimes, :night_payment, :float
  end
end
