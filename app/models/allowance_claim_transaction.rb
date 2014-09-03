class AllowanceClaimTransaction < ActiveRecord::Base
  belongs_to :allowance
  
  attr_accessible :approval_date, :submission_date, :description, :status, :upload,  :allowance_id, :nominal

  #validates :approval_date, presence: true
  
  validates :submission_date, presence: true
  #validates :description, presence: true
  #validates :status, presence: true
  #validates :upload, presence: true
  validates :allowance_id, presence: true
  validates :nominal, presence: true

  def self.search_approved (search, search_by, user, from_page)
    if from_page == "new"
      if search_by == "0"
        where(:allowance_id => user.allowances, :status => 1, :approval_date=> "#{Time.now.year}-01-01".."#{Time.now.year}-12-31" ).order("submission_date desc")
      elsif search_by == "1"
        allowance = Allowance.where(:user_id =>user, :allowance_sub_category_id => search)
        where(:allowance_id => allowance, :status => 1, :approval_date=> "#{Time.now.year}-01-01".."#{Time.now.year}-12-31" ).order("submission_date desc")
      else
        where(:allowance_id => user.allowances, :status => 1, :approval_date=> "#{Time.now.year}-01-01".."#{Time.now.year}-12-31" ).order("submission_date desc")
      end
    elsif from_page == "index"

      search = search.strip rescue nil
      if search_by == "0"
        where(:status => 1 ).order("updated_at desc")
      elsif search_by == "1"
        p "masuk"
        user = User.find_by_email(search)
        allowance = Allowance.where(:user_id => user)
        where(:status => 1, :allowance_id => allowance ).order("updated_at desc")
      elsif search_by == "2"
        allowance = Allowance.where(:allowance_sub_category_id => search)
        where(:status => 1, :allowance_id => allowance ).order("updated_at desc")
      else
        where(:status => 1 ).order("updated_at desc")
      end
    end

  	

  end

  def self.search_rejected(search, search_by, user, from_page)
    if from_page == "new"
      if search_by == "0"
        where(:allowance_id => user.allowances, :status => 2 ).order("submission_date desc")
      elsif search_by == "1"
        allowance = Allowance.where(:user_id =>user, :allowance_sub_category_id => search)
        where(:allowance_id => allowance, :status => 2 ).order("submission_date desc")
      else
        where(:allowance_id => user.allowances, :status => 2 ).order("submission_date desc")
      end
    elsif from_page == "index"

      search = search.strip rescue nil
      if search_by == "0"
        where(:status => 2 ).order("updated_at desc")
      elsif search_by == "1"
        p "masuk"
        user = User.find_by_email(search)
        allowance = Allowance.where(:user_id => user)
        where(:status => 2, :allowance_id => allowance ).order("updated_at desc")
      elsif search_by == "2"
        allowance = Allowance.where(:allowance_sub_category_id => search)
        where(:status => 2, :allowance_id => allowance ).order("updated_at desc")
      else
        where(:status => 2 ).order("updated_at desc")
      end
    end
  	
  			
  end

  def self.search_pending(search, search_by, user, from_page)
    if from_page == "new"
      if search_by == "0"
        where(:allowance_id => user.allowances, :status => 0 ).order("submission_date desc")
      elsif search_by == "1"
        allowance = Allowance.where(:user_id =>user, :allowance_sub_category_id => search)
        where(:allowance_id => allowance, :status => 0 ).order("submission_date desc")
      else
        where(:allowance_id => user.allowances, :status => 0 ).order("submission_date desc")
      end
    elsif from_page == "index"
      search = search.strip rescue nil
      if search_by == "0"
        where(:status => 0 ).order("updated_at desc")
      elsif search_by == "1"
        user = User.find_by_email(search)
        allowance = Allowance.where(:user_id => user)
        where(:status => 0, :allowance_id => allowance ).order("updated_at desc")
      elsif search_by == "2"
        allowance = Allowance.where(:allowance_sub_category_id => search)
        where(:status => 0, :allowance_id => allowance ).order("updated_at desc")
      else
        where(:status => 0 ).order("updated_at desc")
      end
    end
    
    
        
  end

  def self.search_revision(search, search_by, user, from_page)
    if from_page == "new"
      if search_by == "0"
        where(:allowance_id => user, :status => 3 ).order("submission_date desc")  
      elsif search_by == "1"
        allowance = Allowance.where(:user_id =>user, :allowance_sub_category_id => search)
        where(:allowance_id => allowance, :status => 3 ).order("submission_date desc")  
      else
        where(:allowance_id => user, :status => 3 ).order("submission_date desc")  
      end
    elsif from_page == "index"

      search = search.strip rescue nil
      if search_by == "0"
        where(:status => 3 ).order("updated_at desc")
      elsif search_by == "1"
        p "masuk"
        user = User.find_by_email(search)
        allowance = Allowance.where(:user_id => user)
        where(:status => 3, :allowance_id => allowance ).order("updated_at desc")
      elsif search_by == "2"
        allowance = Allowance.where(:allowance_sub_category_id => search)
        where(:status => 3, :allowance_id => allowance ).order("updated_at desc")
      else
        where(:status => 3 ).order("updated_at desc")
      end
    end
    
    
        
  end

end
