class ClaimTransaction < ActiveRecord::Base
  belongs_to :allowance
  attr_accessible :approval_date, :date_submission, :description, :status
end
