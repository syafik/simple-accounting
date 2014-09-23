class AddLongOvertime < ActiveRecord::Migration
  def change
  	add_column :overtimes, :long_overtime, :float
  end
end
