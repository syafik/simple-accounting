class RenameUsersId < ActiveRecord::Migration
  def change
  	rename_column :loan_permissions, :users_id, :user_id
  end
end
