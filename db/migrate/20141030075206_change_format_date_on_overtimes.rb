class ChangeFormatDateOnOvertimes < ActiveRecord::Migration
  def up
    remove_column :overtimes, :start_time
    remove_column :overtimes, :end_time
    add_column :overtimes, :start_time, :datetime
    add_column :overtimes, :end_time, :datetime
    #change_column :overtimes, :start_time, :datetime
    #change_column :overtimes, :end_time, :datetime
  end

  def down
    remove_column :overtimes, :start_time
    remove_column :overtimes, :end_time
    add_column :overtimes, :start_time, :time
    add_column :overtimes, :end_time, :time
    #change_column :overtimes, :start_time, :time
    #change_column :overtimes, :end_time, :time
  end
end
