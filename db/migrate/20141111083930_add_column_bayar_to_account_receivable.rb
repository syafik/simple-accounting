class AddColumnBayarToAccountReceivable < ActiveRecord::Migration
  def change
  	add_column :account_receivables, :bayar, :integer
  end
end
