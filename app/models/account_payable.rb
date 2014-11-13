class AccountPayable < ActiveRecord::Base
  attr_accessible :credit, :date, :debit, :description, :time, :title, :parent_id
  acts_as_tree

   validates :title, presence: true
   validates :credit, presence: true
   validates :debit, presence: true
   validates :date, presence: true
end
