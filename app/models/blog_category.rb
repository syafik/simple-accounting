class BlogCategory < ActiveRecord::Base # :nodoc:
  attr_accessible :name

  has_many :categoriesblogs
  has_many :blogs, :through => :categoriesblogs

end
