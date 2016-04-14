class AllowanceClaimTransaction < ActiveRecord::Base  # :nodoc:
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
        p "==========="
        p allowance_list
      end
    end

    return allowance_list
  end

  def self.user_search(search, user)
    allowance_list ={
      # approveds: where(:status => 1, :allowance_id => user.allowances , :approval_date=> "#{Time.now.year}-01-01".."#{Time.now.year}-12-31" ).order("submission_date desc").order("updated_at desc"),
      approveds: where(:status => 1, :allowance_id => user.allowances ).order("submission_date desc").order("updated_at desc"),
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






def self.approval
  @allowance_claim_transaction = AllowanceClaimTransaction.find(params[:format])
    #cek status
    decision = params[:decision]

    if decision == "rejected"
      @allowance_claim_transaction.update_attributes(:status=>2, :description=> params[:description], :approval_date => Date.today)
      redirect_to allowance_claim_transactions_path

    elsif decision == "revision"
      @allowance_claim_transaction.update_attributes(:status=>3, :description=> params[:description], :approval_date => Date.today)
      redirect_to allowance_claim_transactions_path
    else
      #looking for total nominal by allowance_id
      #AllowanceClaimTransaction.where(:allowance_id => params[:allowance_id], :status => true, :approval_date => "#{Time.now.year}-01-01".."#{Time.now.year}-12-31")

      allowance_claim_transaction = AllowanceClaimTransaction.where(:allowance_id => params[:allowance_id], :status => 1, :approval_date=> "#{Time.now.year}-01-01".."#{Time.now.year}-12-31" )
      totalnominal = 0
      allowance_claim_transaction.each do |allowance_claim_transaction|
        totalnominal = totalnominal + allowance_claim_transaction.nominal

      end
      #get nominal
      nominal = params[:nominal]
      p totalnominal


      #totalnominal + nominal;
      finalnominal = totalnominal.to_f + nominal.to_f
      #------------------------

      #finding user value
      val = Allowance.find(params[:allowance_id]).value



      if finalnominal < val
        @allowance_claim_transaction.update_attributes(:status=>1, :description=> params[:description], :approval_date => Date.today)
        redirect_to allowance_claim_transactions_path
      else
        redirect_to allowance_claim_transactions_path
      end
    end

  end

end
