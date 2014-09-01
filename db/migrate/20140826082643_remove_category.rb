class RemoveCategory < ActiveRecord::Migration
  def change
  	remove_column :allowance_claim_transactions, :category
  end
end
