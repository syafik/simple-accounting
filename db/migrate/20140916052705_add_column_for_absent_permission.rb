class AddColumnForAbsentPermission < ActiveRecord::Migration
  def change
  	add_column :absent_permissions, :start_date, :date
  	add_column :absent_permissions, :end_date, :date
  	add_column :absent_permissions, :message, :text
  end
end
