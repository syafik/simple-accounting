class AddLongDayAndLongNightToOvertimes < ActiveRecord::Migration
  def change
    add_column :overtimes, :long_day, :float, default: 0
    add_column :overtimes, :long_night, :float, default: 0
  end
end
