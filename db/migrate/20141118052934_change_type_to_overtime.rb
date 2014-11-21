class ChangeTypeToOvertime < ActiveRecord::Migration
  def up
    change_column :overtimes, :start_time, :time
    change_column :overtimes, :end_time, :time
  end

  def down
  	change_column :overtimes, :start_time, :datetime
    change_column :overtimes, :end_time, :datetime
  end

end
