class ChangeDatetimeToDateInAccountReceivable < ActiveRecord::Migration
  def up
  	change_column :account_receivables, :date, :date
  end

  def down
  	change_column :account_receivables, :date, :datetime
  end
end
