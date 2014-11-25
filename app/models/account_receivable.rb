class AccountReceivable < ActiveRecord::Base
  attr_accessible :credit, :date, :debit, :description, :title, :parent_id

  # callback setelah account receivable dibuat
# =====
  after_create :create_transaction

  def create_transaction
    puts 'transaction was successfully updated'
    if parent_id.nil?
      Transaction.create(:date => self.date, :description => self.description, :value => self.credit, :is_debit => false)
    else
      Transaction.create(:date => self.date, :description => self.description, :value => self.debit, :is_debit => true)
    end
  end
# =======
  has_one :transaction

  validates :title, presence: true
  validates :debit, presence: true, :numericality => { :greater_than_or_equal_to => @sisa.to_i }
  validates :credit, presence: true
  validates :description, presence: true
  validates :date, presence: true, allow_blank: false
  
  acts_as_tree

end
