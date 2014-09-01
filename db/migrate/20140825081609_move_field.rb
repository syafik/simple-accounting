class MoveField < ActiveRecord::Migration
  def change
  	remove_column :allowances, :max_day
  end
end
