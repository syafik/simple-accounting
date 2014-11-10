class AddParentidToAccountPayable < ActiveRecord::Migration
  def change
  	add_column :account_payables, :parent_id, :integer
  end
end
