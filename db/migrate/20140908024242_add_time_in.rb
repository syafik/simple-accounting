class AddTimeIn < ActiveRecord::Migration
  def change
  	add_column :absents, :time_in, :time
  	add_column :absents, :time_out, :time
  end
end
