class Reimbursement < ActiveRecord::Base
  attr_accessible :no_kwitasi, :notes, :reimbursement_type, :rumah_sakit, :status, :total_claim, :user_id, :year_insurance_id, :total_day, :total_approve
  belongs_to :user
  belongs_to :year_insurance

  before_create :set_status
  before_save :set_user

  def set_user
    if self.year_insurance
      family = self.year_insurance.family
      if family.parent_id.nil?
        self.user_id = family.id
      else
        self.user_id = family.parent_id
      end
    end
  end

  def set_status
    self.status = "process"
  end
  def self.statuses
    ["prosess", "approve", "reject"]
  end
  def self.statuses_type
    ["RJ", "RI", "RB NORMAL", "RB CAESAR", "OPERASI"]
  end
  def show_status
    string = if status == "process"
      "<label class=\"btn btn-default btn-xs\">Process</label>"
    elsif status == "approve"
      "<label class=\"btn btn-success btn-xs\">Approve</label>"
    else
      "<label class=\"btn btn-danger btn-xs\">Reject</label>"
    end
    string.html_safe
  end
  def self.total_rj
    self.sum("total_claim").where("reimbursement_type = ? AND status in ?", "RJ", ["prosess", "approve"])
  end
end
