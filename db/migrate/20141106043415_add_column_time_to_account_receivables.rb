class AddColumnTimeToAccountReceivables < ActiveRecord::Migration
  def change
  	add_column :account_receivables, :time, :string
  end
end
