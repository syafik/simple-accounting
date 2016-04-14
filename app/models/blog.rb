class Blog < ActiveRecord::Base # :nodoc:
  attr_accessible :blog_category_ids, :content, :published, :title, :user_id

  after_update :add_point
  before_save :image

  has_one :point_history, :as => :point_historyable

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :categoriesblogs, :dependent => :destroy
  has_many :blog_categories, :through => :categoriesblogs

  validates :title, presence: true
  validates :content, presence: true
  validates :blog_category_ids, presence: true

  def create_history(point_id,point)
    self.build_point_history(:user_id => self.user_id, :point_id => point_id, :points => point).save
  end

  def add_point
    user = User.find(self.user_id)
    pp = Point.where("name like '%blog%'").first
    point = pp.point
    if self.published_changed?
      user.point += point
      user.save
      create_history(pp.id,point)
    end
  end

  def image
    if !self.content.include? "http://localhost:3000/ckeditor_assets"
      self.content = self.content.gsub('/ckeditor_assets', 'http://localhost:3000/ckeditor_assets')
    end
  end

end
