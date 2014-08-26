class Absent < ActiveRecord::Base
	belongs_to :user
  attr_accessible :categories, :date, :description, :user_id
end
