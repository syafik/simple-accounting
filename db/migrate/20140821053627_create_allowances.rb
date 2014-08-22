class CreateAllowances < ActiveRecord::Migration
  def change
    create_table :allowances do |t|
      t.float :value
      t.integer :max_day
      t.references :allowance_category
      t.references :user

      t.timestamps
    end
    add_index :allowances, :allowance_category_id
    add_index :allowances, :user_id
  end
end
