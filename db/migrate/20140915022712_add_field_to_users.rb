class AddFieldToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :first_name, :string
  	add_column :users, :mid_name, :string
  	add_column :users, :last_name, :string
  end
end
