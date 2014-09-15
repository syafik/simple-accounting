class RemvoefDateBirth < ActiveRecord::Migration
  def change
  	remove_column :users, :date_birth
  end
end
