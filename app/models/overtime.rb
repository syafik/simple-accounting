class Overtime < ActiveRecord::Base
belongs_to :user 

  attr_accessible :date, :description, :long_overtime, :user_id, :start_time, :end_time
  validates  :date, :start_time, :end_time,   presence: true
end
