class ModifiedDataTypeStatusOnOvertime < ActiveRecord::Migration
  def change
  	remove_column :overtimes, :status
  	add_column :overtimes, :status, :integer
  end
end
