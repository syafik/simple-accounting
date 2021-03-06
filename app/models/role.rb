class Role < ActiveRecord::Base # :nodoc:
	acts_as_paranoid
	has_one :user
	attr_accessible :name

	# validation
	validates :name, presence: true
end
