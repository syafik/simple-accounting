class Categoriesblog < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :blog
  belongs_to :blog_category
end
