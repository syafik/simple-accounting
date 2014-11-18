class AccountPayable < ActiveRecord::Base
  attr_accessible :credit, :date, :debit, :description, :time, :title, :parent_id
  acts_as_tree

   validates :title, presence: true
   validates :credit, presence: true, :numericality => { :greater_than_or_equal_to => 1 }
   validates :debit, presence: true, :numericality => { :greater_than_or_equal_to => 1 }
   validates :date, presence: true
end
