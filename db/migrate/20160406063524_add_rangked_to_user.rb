class AddRangkedToUser < ActiveRecord::Migration
  def change
    add_column :users, :ranked, :boolean, :default => true
  end
end
