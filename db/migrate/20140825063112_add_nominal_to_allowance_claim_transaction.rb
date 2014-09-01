class AddNominalToAllowanceClaimTransaction < ActiveRecord::Migration
  def change
  	add_column :allowance_claim_transactions, :nominal, :float
  end
end
