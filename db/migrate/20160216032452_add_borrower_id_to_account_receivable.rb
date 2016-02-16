class AddBorrowerIdToAccountReceivable < ActiveRecord::Migration
  def change
    add_column :account_receivables, :borrower_id, :integer
    add_column :account_receivables, :borrower_type, :string
  end
end
