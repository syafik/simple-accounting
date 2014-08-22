class Allowance < ActiveRecord::Base
  #has_many :claim_transaction
  belongs_to :allowance_sub_category
  belongs_to :user

  attr_accessible :max_day, :value, :user_id, :allowance_sub_category_id
  validates :max_day, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 365 }
   
end
