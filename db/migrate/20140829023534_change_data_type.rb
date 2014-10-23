class ChangeDataType < ActiveRecord::Migration
  def up
  	change_column :allowance_claim_transactions, :status, :integer
  end

  def down
    change_column :allowance_claim_transactions, :status, :boolean
  end
end
