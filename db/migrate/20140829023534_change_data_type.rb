class ChangeDataType < ActiveRecord::Migration
  def change
  	change_column :allowance_claim_transactions, :status, 'integer USING CAST(status AS integer)'
  end
end
