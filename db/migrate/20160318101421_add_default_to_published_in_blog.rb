class AddDefaultToPublishedInBlog < ActiveRecord::Migration
  def change
    change_column :blogs , :published , :boolean , :default => false
  end
end
