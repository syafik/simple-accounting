class RemoveUserIdFromSalary < ActiveRecord::Migration
  def change
  	remove_column :salaries, :user_id
  end
end
