class BestEmployee < ActiveRecord::Base # :nodoc:
  attr_accessible :user_id, :date, :total_point, :min_point
  belongs_to :user
  scope :this_month, -> { where(date: (Date.today.end_of_month)) }
  scope :last_month, -> { where(date: ((Date.today - 1.month).end_of_month))}
end
