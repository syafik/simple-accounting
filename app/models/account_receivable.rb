class AccountReceivable < ActiveRecord::Base
  attr_accessible :credit, :date, :debit, :description, :title, :parent_id
  validates :title, presence: true
  validates :debit, presence: true
  validates :credit, presence: true
  validates :description, presence: true
  validates :date, presence: true, allow_blank: false
  acts_as_tree
end
