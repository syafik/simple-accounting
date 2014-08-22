class AllowanceCategory < ActiveRecord::Base
	has_many :allowance_sub_category
	attr_accessible :name
	validates :name, uniqueness: true
end
