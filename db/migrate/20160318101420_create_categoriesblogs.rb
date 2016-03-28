class CreateCategoriesblogs < ActiveRecord::Migration
  def change
    create_table :categoriesblogs do |t|
      t.references :blogs, index: true
      t.references :blog_categories, index: true

      t.timestamps null: false
    end
  end
end
