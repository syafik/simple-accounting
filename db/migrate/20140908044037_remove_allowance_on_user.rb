class RemoveAllowanceOnUser < ActiveRecord::Migration
  def change
  	remove_column :users, :wife_allowances
  	remove_column :users, :child_allowances
  end
end
