class AddColumnToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :name, :string 
  	add_column :users, :date_birth, :date
  	add_column :users, :telephone, :string
  	add_column :users, :address, :string
  	add_column :users, :date_entry, :date
  	add_column :users, :gender, :boolean
  	add_column :users, :religion, :string
  	add_column :users, :status, :boolean
  	add_column :users, :number_of_children, :integer
  	add_column :users, :salary, :float
  	add_column :users, :wife_allowances, :float
  	add_column :users, :child_allowances, :float
  	add_column :users, :overtime_pay, :float
  	add_column :users, :role, :string                           
  end
end
