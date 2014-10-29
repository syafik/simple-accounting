class User < ActiveRecord::Base
  attr_accessible :avatar
  has_attached_file :avatar,
                    :default_url =>  ActionController::Base.helpers.asset_path('avatar.png'),
                    :styles => {
                      :thumb => "50x50>",
                      :small => "120x120"
                    }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, :attributes => :avatar, :less_than => 1.megabytes
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
  attr_accessible :email, :password, :password_confirmation, :remember_me, :telephone, :address, :gender, :role_id, :first_name, :last_name, :birth_date, :salary_histories_attributes, :overtime_payment_histories_attributes, :religion, :max_furlough, :position, :account_number, :bank_name, :account_branch_name, :account_name, :allowed_jamsostek
  # attr_accessible :title, :body


  validates :email, uniqueness: true
  validates :telephone, presence: true, numericality: { only_integer: true }
  validates :address, :role_id, :first_name, :birth_date, :position, :bank_name, :account_branch_name, :account_name, presence: true
  validates :account_number, presence: true, numericality: { only_integer: true }

  def is_admin?
    self.role.name == "admin"
  end

  def is_user?
    self.role.name == "user"
  end

  def get_all_sub_category
    allowances.select("allowance_sub_category_id").map{|a| [a.allowance_sub_category.try(:name), a.try(:id)]}
  end

  def self.get_all_sub_category_class(user)
    user.allowances.select("allowance_sub_category_id").map{|a| [a.allowance_sub_category.try(:name), a.try(:id)]}
  end

  def my_salary
    salary_histories.activate.sum(:payment)
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
