class Allowance < ActiveRecord::Base
  belongs_to :allowance_sub_category
  belongs_to :user
  has_many :allowance_claim_transactions
  
  

  attr_accessible :value, :user_id, :allowance_sub_category_id

  validates :user_id, uniqueness: { scope: :allowance_sub_category_id,
    message: "Nama Dengan Tunjangan Tersebut Telah Terdaftar Sebelumnya" }

    validates :value, presence: true
    validates :user_id, presence: true
    validates :allowance_sub_category_id, presence: true




    def self.search(search, search_by)
      search = search.strip rescue nil
      if search_by == "3"
        where(:allowance_sub_category_id => search)
      elsif search_by == "1"
       user = User.find_by_email(search)
       where(:user_id => user)
     elsif search_by == "2"
      allowance_category = AllowanceCategory.find(search)
      allowance_sub_category = allowance_category.allowance_sub_categories
      where(:allowance_sub_category_id => allowance_sub_category)
    elsif search_by == "0"
      find(:all)  
    else
      find(:all)
    end

  end

  def self.search
  end


  
  

end
