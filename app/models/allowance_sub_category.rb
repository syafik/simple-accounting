class AllowanceSubCategory < ActiveRecord::Base
  belongs_to :allowance_category
  has_many :allowance
  attr_accessible :name, :allowance_category_id
  validates :name, uniqueness: { scope: :allowance_category_id,
    message: "Nama Dengan Tunjangan Tersebut Telah Terdaftar Sebelumnya" }
end
