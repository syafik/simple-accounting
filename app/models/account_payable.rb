class AccountPayable < ActiveRecord::Base
  attr_accessible :credit, :date, :debit, :description, :time
end
