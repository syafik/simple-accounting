class Family < ActiveRecord::Base  # :nodoc:
  acts_as_tree
  belongs_to :familyable,  polymorphic: true
  has_many :year_insurances

  attr_accessible :birth_date, :familyable_id, :familyable_type, :is_active, :name, :parent_id, :status
  scope :active, -> {where("is_active IS TRUE")}
  def self.statuses
    ["Suami", "Istri", "Anak"]
  end
end
