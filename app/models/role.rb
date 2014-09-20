class Role < ActiveRecord::Base
	has_one :user
	attr_accessible :name

	# validation
	validates :name, presence: true
end
