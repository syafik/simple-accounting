class AllowanceCategory < ActiveRecord::Base
	has_many :allowance_sub_categories, dependent: :destroy
	attr_accessible :name, :allowance_sub_categories_attributes
	accepts_nested_attributes_for :allowance_sub_categories
	
	validates :name, uniqueness: true
	validates :name, presence: true
end
