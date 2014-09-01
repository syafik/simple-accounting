class User < ActiveRecord::Base
	has_many :allowances, dependent: :destroy
  has_many :absents
  
  has_many :overtime , dependent: :destroy
  has_many :salary , dependent: :destroy
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  def get_all_sub_category
    allowances.select("allowance_sub_category_id").map{|a| [a.allowance_sub_category.try(:name), a.try(:id)]}
  end

  def self.get_all_sub_category_class(user)
    user.allowances.select("allowance_sub_category_id").map{|a| [a.allowance_sub_category.try(:name), a.try(:id)]}
  end
end
