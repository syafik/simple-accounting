class AddSlugToBlogCategory < ActiveRecord::Migration
  def change
    add_column :blog_categories, :slug, :string
  end
end
