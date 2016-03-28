class RenameColumnFromCategoriesBlogs < ActiveRecord::Migration
  def change
    rename_column :categoriesblogs, :blogs_id, :blog_id
    rename_column :categoriesblogs, :blog_categories_id, :blog_category_id
  end
end
