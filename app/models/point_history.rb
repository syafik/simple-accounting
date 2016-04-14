class PointHistory < ActiveRecord::Base # :nodoc:
  attr_accessible :points, :point_historyable_id, :point_historyable_type, :point_id, :user_id,:point_historyable

  belongs_to :user
  belongs_to :point
  belongs_to :point_historyable, :polymorphic => true

  default_scope { order('created_at DESC') }

  scope :this_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) }
  scope :this_year, -> { where(created_at: Time.now.beginning_of_year..Time.now.end_of_year) }

end
