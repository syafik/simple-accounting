class AddPublishedatToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :published_at, :timestamp
  end
end
