class AlterOvertime < ActiveRecord::Migration
  def change
  	remove_column :overtimes,  :long_overtime
  	add_column :overtimes, :start_time, :time
  	add_column :overtimes, :end_time, :time
  end
end
