class AddTotalWorkTime < ActiveRecord::Migration
  def change
  	add_column :absents, :total_work_time, :float
  end
end
