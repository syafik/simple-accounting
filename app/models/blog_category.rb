class BlogCategory < ActiveRecord::Base # :nodoc:
  attr_accessible :name
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :categoriesblogs
  has_many :blogs, :through => :categoriesblogs

end
