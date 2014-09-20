class User < ActiveRecord::Base
  acts_as_paranoid
  has_many :allowances, dependent: :destroy
  has_many :absents
  has_many :absent_permissions
  has_many :loan_permissions
  belongs_to :role
  
  has_many :salary_histories
  has_many :overtimes
  has_many :overtime_payment_histories
  accepts_nested_attributes_for :salary_histories
  accepts_nested_attributes_for :overtime_payment_histories



  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :telephone, :address, :gender, :role_id, :first_name, :mid_name, :last_name, :birth_date, :salary_histories_attributes, :overtime_payment_histories_attributes, :religion, :max_furlough
  # attr_accessible :title, :body


  validates :email, uniqueness: true
  validates :telephone, presence: true
  validates :address, presence: true
  # validates :gender, presence: true
  validates :role_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birth_date, presence: true


  def get_all_sub_category
    allowances.select("allowance_sub_category_id").map{|a| [a.allowance_sub_category.try(:name), a.try(:id)]}
  end

  def self.get_all_sub_category_class(user)
    user.allowances.select("allowance_sub_category_id").map{|a| [a.allowance_sub_category.try(:name), a.try(:id)]}
  end
end
