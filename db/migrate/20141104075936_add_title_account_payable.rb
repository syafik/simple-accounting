class AddTitleAccountPayable < ActiveRecord::Migration
  def change
  	add_column :account_payables, :title, :string
  end
end
