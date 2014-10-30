class ChangeDataType < ActiveRecord::Migration
  def up
    remove_column :allowance_claim_transactions, :status
    add_column :allowance_claim_transactions, :status, :integer
  	#change_column :allowance_claim_transactions, :status, :integer rescue nil
  end

  def down
    remove_column :allowance_claim_transactions
    add_column :allowance_claim_transactions, :status, :boolean
    #change_column :allowance_claim_transactions, :status, :boolean rescue nil
  end
end
