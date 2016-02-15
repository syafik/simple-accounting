class YearInsurance < ActiveRecord::Base
  attr_accessible :family_id, :grade_id, :saldo_rj, :year
  belongs_to :grade
  belongs_to :family
  has_many :reimbursements
  scope :active, -> {where("year = ? ", Date.today.year.to_s)}

  def self.by_year(year = Date.today.year)
     year = Date.today.year unless year.present?
    self.where("year = ?", year.to_s)
  end
end
