class AddColumnOnUsers < ActiveRecord::Migration
  def change
  	add_column :users,  :account_number, :string
  	add_column :users,  :bank_name, :string
  	add_column :users,  :account_branch_name, :string
  	add_column :users,  :account_name, :string


  end
end
