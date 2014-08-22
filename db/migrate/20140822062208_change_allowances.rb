class ChangeAllowances < ActiveRecord::Migration
  def change
  	remove_index :allowances, :allowance_category_id
  	remove_column :allowances, :allowance_category_id
  	add_column :allowances, :allowance_sub_category_id, :integer
    add_index :allowances, :allowance_sub_category_id
  end
end
