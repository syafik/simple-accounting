class AccountPayable < ActiveRecord::Base # :nodoc:
  attr_accessible :credit, :date, :debit, :description, :time, :title, :parent_id

  # callback setelah account payable dibuat
# =====
  after_create :create_transaction

  def create_transaction
    puts 'transaction was successfully updated'
    if parent_id.nil?
      Transaction.create(:date => self.date, :description => self.description, :value => self.debit, :is_debit => true)
    else
      Transaction.create(:date => self.date, :description => self.description, :value => self.credit, :is_debit => false)
    end
  end
# =======

  acts_as_tree

   validates :title, presence: true
   validates :credit, presence: true
   validates :debit, presence: true
   validates :date, presence: true
   validates :description, presence: true
end
