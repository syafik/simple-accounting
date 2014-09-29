class AddStatusOnOVertime < ActiveRecord::Migration
  def change
  	add_column :overtimes, :status, :boolean
  end
end
