class ChangeReference < ActiveRecord::Migration
  def change
  	remove_column :allowance_claim_transactions, :allowance_sub_category_id
  	add_column :allowance_claim_transactions, :allowance_id, :integer
  	add_index :allowance_claim_transactions, :allowance_id

  	
  end
end
