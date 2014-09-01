class AllowanceClaimTransaction < ActiveRecord::Base
  belongs_to :allowance
  
  attr_accessible :approval_date, :submission_date, :description, :status, :upload,  :allowance_id, :nominal

  #validates :approval_date, presence: true
  
  validates :submission_date, presence: true
  #validates :description, presence: true
  #validates :status, presence: true
  #validates :upload, presence: true
  validates :allowance_id, presence: true
  validates :nominal, presence: true

end
