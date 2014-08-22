class CreateAllowanceSubCategories < ActiveRecord::Migration
  def change
    create_table :allowance_sub_categories do |t|
      t.string :name
      t.references :allowance_category

      t.timestamps
    end
    add_index :allowance_sub_categories, :allowance_category_id
  end
end
