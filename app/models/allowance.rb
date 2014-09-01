class Allowance < ActiveRecord::Base
  belongs_to :allowance_sub_category
  belongs_to :user
  has_many :allowance_claim_transactions
  
  

  attr_accessible :value, :user_id, :allowance_sub_category_id
  validates :value, presence: true
  validates :user_id, presence: true
  validates :allowance_sub_category_id, presence: true
  
  
   
end
