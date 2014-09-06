class Absent < ActiveRecord::Base
	belongs_to :user
  attr_accessible :categories, :date, :description, :user_id, :time_in, :time_out

  # before_save :convert_date_string_to_timestamp

  # def convert_date_string_to_timestamp
  # end
end
