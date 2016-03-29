class BlogCategory < ActiveRecord::Base
  attr_accessible :name

  has_many :categoriesblogs
  has_many :blogs, :through => :categoriesblogs

end
