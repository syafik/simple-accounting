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

  def self.admin_search(search, user)
    allowance_list ={
      approveds: where(:status => 1 ).order("updated_at desc"),
      rejecteds:  where(:status => 2 ).order("updated_at desc"),
      pendings: where(:status => 0 ).order("updated_at desc"),
      revisions: where(:status => 3 ).order("updated_at desc")
    }

    

    if user.role == "Admin"
      if search

        # lookin search category
        status = nil
        category = search["status"]
        if category == "pending"
          status = 0
        elsif category == "approved"
          status = 1
        elsif category == "rejected"
          status = 2
        elsif category == "revision"
          status = 3
        end

        search[category] = search[category].strip rescue nil
        if search["by_"+category] == "0"
          allowance_list[(category+"s").to_sym] = where(:status => status ).order("updated_at desc")
        elsif search["by_"+category] == "1"
          user = User.find_by_email(search[category])
          allowance = Allowance.where(:user_id => user)
          allowance_list[(category+"s").to_sym] = where(:status => status, :allowance_id => allowance ).order("updated_at desc")
        elsif search["by_"+category] == "2"
          allowance = Allowance.where(:allowance_sub_category_id => search[category])
          allowance_list[(category+"s").to_sym] = where(:status => status, :allowance_id => allowance ).order("updated_at desc")
        elsif search["by_"+category] == "3" && search["to_"+category] == "" && search["from_"+category] != ""
          allowance_list[(category+"s").to_sym] = where(:status => status, :submission_date=> search["from_"+category]..search["to_"+category] ).order("updated_at desc")
        elsif search["by_"+category] == "4" && search["to_"+category] == "" && search["from_"+category] != ""
          allowance_list[(category+"s").to_sym] = where(:status => status, :approval_date=> search["from_"+category]..search["to_"+category] ).order("updated_at desc")
        end
      else
        allowance_list
      end
    end
    
    return allowance_list
  end

  def self.user_search(search, user)
    allowance_list ={
      approveds: where(:status => 1, :allowance_id => user.allowances , :approval_date=> "#{Time.now.year}-01-01".."#{Time.now.year}-12-31" ).order("submission_date desc").order("updated_at desc"),
      rejecteds:  where(:status => 2, :allowance_id => user.allowances ).order("updated_at desc"),
      pendings: where(:status => 0, :allowance_id => user.allowances ).order("updated_at desc"),
      revisions: where(:status => 3, :allowance_id => user.allowances ).order("updated_at desc")
    }

    if search

        # lookin search category
        status = nil
        category = search["status"]
        if category == "pending"
          status = 0
        elsif category == "approved"
          status = 1
        elsif category == "rejected"
          status = 2
        elsif category == "revision"
          status = 3
        end

        search[category] = search[category].strip rescue nil
        if search["by_"+category] == "0"
          allowance_list[(category+"s").to_sym] = where(:status => status, :allowance_id => user.allowances ).order("updated_at desc")
        elsif search["by_"+category] == "1"
          allowance = Allowance.where(:allowance_sub_category_id => search[category], :user_id => user)
          allowance_list[(category+"s").to_sym] = where(:status => status, :allowance_id => allowance).order("updated_at desc")
        elsif search["by_"+category] == "2" && search["to_"+category] == "" && search["from_"+category] != ""
          allowance_list[(category+"s").to_sym] = where(:status => status, :allowance_id => user.allowances, :submission_date=> search["from_"+category]..search["to_"+category] ).order("updated_at desc")
        elsif search["by_"+category] == "3" && search["to_"+category] == "" && search["from_"+category] != ""
          allowance_list[(category+"s").to_sym] = where(:status => status, :allowance_id => user.allowances, :approval_date=> search["from_"+category]..search["to_"+category] ).order("updated_at desc")
        end
      else
        allowance_list
      end

      p "== model =="
      p allowance_list
      return allowance_list
  end





  def self.search_approved (search, search_by, user, from_page, from_date, to_date)
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
        user = User.find_by_email(search)
        allowance = Allowance.where(:user_id => user)
        where(:status => 1, :allowance_id => allowance ).order("updated_at desc")
      elsif search_by == "2"
        allowance = Allowance.where(:allowance_sub_category_id => search)
        where(:status => 1, :allowance_id => allowance ).order("updated_at desc")
      elsif search_by == "3"
        where(:status => 1, :submission_date=> from_date..to_date ).order("updated_at desc")
      elsif search_by == "4"
        p from_date
        where(:status => 1, :approval_date=> from_date..to_date ).order("updated_at desc")
      else
        where(:status => 1 ).order("updated_at desc")
      end
    end



  end

  def self.search_rejected(search, search_by, user, from_page, from_date, to_date)
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
      elsif search_by == "3"
        where(:status => 2, :submission_date=> from_date..to_date ).order("updated_at desc")
      elsif search_by == "4"
        where(:status => 2, :approval_date=> from_date..to_date ).order("updated_at desc")
      else
        where(:status => 2 ).order("updated_at desc")
      end
    end

  #   query_allowance = ""
  #   query_allowance = "user_id = #{User.find_by_email(search).id}" if search_by.eql?("1")
  #   query_allowance = "allowance_sub_category_id = #{allowance}" if search_by.eql?("2")
    
  #   unless query_allowance.blank?
  #     allowance_list = Allowance.where(query_allowance)
  #   end
    
  #   conditions = []

  #   conditions  << "status = 2"
  #   conditions  << "allowance_id IN (#{allowance_list.map(&:id)})" unless query_allowance.blank?
  #   conditions  << "submission_date = (#{allowance_list.map(&:id)})" if  search_by.eql?("3")
  #   conditions = conditions.join(" AND ")
  # where(conditions)


  end

  def self.search_pending(search, search_by, user, from_page, from_date, to_date)
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
      elsif search_by == "3"
        where(:status => 0, :submission_date=> from_date..to_date ).order("updated_at desc")
      else
        where(:status => 0 ).order("updated_at desc")
      end
    end
    
    

  end

  def self.search_revision(search, search_by, user, from_page, from_date, to_date)
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
