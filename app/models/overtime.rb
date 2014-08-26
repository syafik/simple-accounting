class Overtime < ActiveRecord::Base
belongs_to :user 

  attr_accessible :date, :description, :long_overtime, :user_id
  validates  :date, :description,   presence: true
end
