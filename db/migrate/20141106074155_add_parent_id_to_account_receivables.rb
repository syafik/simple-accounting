class AddParentIdToAccountReceivables < ActiveRecord::Migration
  def change
  	add_column :account_receivables, :parent_id, :integer
  end
end
