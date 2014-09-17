class ModifiedDataTypeStatus < ActiveRecord::Migration
  def change
  	remove_column :absent_permissions, :status
  	add_column :absent_permissions, :status, :integer
  end
end
