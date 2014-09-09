class Absent < ActiveRecord::Base
	belongs_to :user
  	attr_accessible :categories, :date, :description, :user_id, :time_in, :time_out

  	# validates :date, presence: true
  	# validates :categories, presence: true
  	# validates :description, presence: true
  	# validates :user_id, presence:true

  # before_save :convert_date_string_to_timestamp

  # def convert_date_string_to_timestamp
  # end
end
