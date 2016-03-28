class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.boolean :published
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
