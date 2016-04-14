class AbsentPermission < ActiveRecord::Base # :nodoc:
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

  def self.have_been_taken(user)
    # get total have been taken
    hbt = AbsentPermission.where("user_id = ? AND status = ? AND extract(year  from approval_date) = ?", user.id, 3, Time.now.year).sum(:long)

    return hbt
  end

  def save_to_absent

    tamp_start_date = start_date
    tamp_end_date = end_date
    tamp_long = long
    one = 1

    tamp_category = nil

    if category == 1
      tamp_category = 3
    else
      tamp_category = 5
    end

    absent = []

    0.upto(tamp_long) do |i|
      puts tamp_start_date.class
      absent << {user_id:  user_id, categories:  tamp_category, date:  tamp_start_date.to_s}
      tamp_start_date+=1
    end

    @absents = Absent.create(absent)

  end
end
