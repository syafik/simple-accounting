class RemoveFieldFromUser < ActiveRecord::Migration
  def change
  	remove_column :users, :name
  	remove_column :users, :overtime_pay
  	remove_column :users, :salary
  	remove_column :users, :number_of_children
  end
end
