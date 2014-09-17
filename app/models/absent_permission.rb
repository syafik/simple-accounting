class AbsentPermission < ActiveRecord::Base
	belongs_to :user
	attr_accessible :approval_date, :category, :date_submission, :description, :long, :status, :user_id, :submission_date, :start_date, :message, :end_date


	def self.user_search(search, user)
		ap_list ={

      approveds: where(:status => 1, :user_id => user ).order("submission_date desc").order("updated_at desc"),
      rejecteds:  where(:status => 2, :user_id => user ).order("updated_at desc"),
      pendings: where(:status => 0, :user_id => user ).order("updated_at desc"),
      takens: where(:status => 3, :user_id => user ).order("updated_at desc"),
      declines: where(:status => 4, :user_id => user ).order("updated_at desc")
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
        	
        elsif search["by_"+category] == "1"
        	
        elsif search["by_"+category] == "2" && search["to_"+category] == "" && search["from_"+category] != ""
        	
        elsif search["by_"+category] == "3" && search["to_"+category] == "" && search["from_"+category] != ""
        	
        end
      else
      	ap_list
      end

      return ap_list
    end

    def self.admin_search(search, user)
      ap_list ={
        approveds: where(:status => 1 ).order("updated_at desc"),
        rejecteds:  where(:status => 2 ).order("updated_at desc"),
        pendings: where(:status => 0 ).order("updated_at desc"),
        takens: where(:status => 3 ).order("updated_at desc"),
        declines: where(:status => 4 ).order("updated_at desc")

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
          
        elsif search["by_"+category] == "1"
         
        elsif search["by_"+category] == "2"
          
        elsif search["by_"+category] == "3" && search["to_"+category] == "" && search["from_"+category] != ""
          
        elsif search["by_"+category] == "4" && search["to_"+category] == "" && search["from_"+category] != ""
          
        end
      else
        ap_list
        p "==========="
        p ap_list
      end
    end
    
    return ap_list
  end
end
