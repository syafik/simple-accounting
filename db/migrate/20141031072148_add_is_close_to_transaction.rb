class AddIsCloseToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :is_close, :boolean, default: false
  end
end
