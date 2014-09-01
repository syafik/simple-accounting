class AllowanceSubCategory < ActiveRecord::Base
  #Relation
  has_many :allowances, dependent: :destroy
  belongs_to :allowance_category

  attr_accessible :name, :allowance_category_id, :max_day

  #Validation
  validates :name, uniqueness: { scope: :allowance_category_id,
    message: "Nama Dengan Tunjangan Tersebut Telah Terdaftar Sebelumnya" }
    validates :max_day, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 365 }

  validates :name, presence: true
  
  validates :max_day, presence: true
end
