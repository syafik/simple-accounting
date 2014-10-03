class AddColumnOnUser < ActiveRecord::Migration
  def change
  	add_column :users, :allowed_jamsostek, :boolean
  end
end
