class RemoveMidName < ActiveRecord::Migration
  def change
  	remove_column :users, :mid_name
  end
end
