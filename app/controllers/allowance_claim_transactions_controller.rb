
class AllowanceClaimTransactionsController < ApplicationController
	before_filter :get_allowance_detil
  before_filter :get_history,  :only => [:new, :create] 

  def index
    @allowance_claim_transaction_approveds = AllowanceClaimTransaction.where(:status => 1 ).order("updated_at desc").paginate(:page => params[:page], :per_page => 5)
    @allowance_claim_transaction_rejecteds = AllowanceClaimTransaction.where(:status => 2 ).order("submission_date desc").paginate(:page => params[:page], :per_page => 5)
    @allowance_claim_transaction_pendings = AllowanceClaimTransaction.where(:status => 0 ).order("submission_date desc").paginate(:page => params[:page], :per_page => 5)
    @allowance_claim_transaction_revisi = AllowanceClaimTransaction.where(:status => 3 ).order("submission_date desc").paginate(:page => params[:page], :per_page => 5)
  end

  def new
  	@allowance_claim_transaction = AllowanceClaimTransaction.new
    
    @allowance_sub_category = AllowanceSubCategory.all.map { |allowance_sub_category| [allowance_sub_category.name, allowance_sub_category.id]}
  end

  def create
    val = current_user.allowances.find(params[:allowance_category_id]).value 
    totalnominal = params[:totalnominal][:nominal]
    nominal = params[:allowance_claim_transaction][:nominal]
    my_nominal = totalnominal.to_f + nominal.to_f
    
    @allowance_claim_transaction = AllowanceClaimTransaction.new(params[:allowance_claim_transaction])

    if my_nominal < val && @allowance_claim_transaction.save
      redirect_to allowance_claim_transactions_path
    else    
      render 'new'
    end
  end

  def show
    @allowance_claim_transaction = AllowanceClaimTransaction.find(params[:id])
  end

  def edit
    @allowance_claim_transaction = AllowanceClaimTransaction.find(params[:id])

    respond_to do |format|
      #format.html
      format.js
    end
  end

  def set_approval
    #note
    #Time.now.year -> the way to get year

    @allowance_claim_transaction = AllowanceClaimTransaction.find(params[:format])
    #cek status
    decision = params[:decision]
    p decision
    if decision == "rejected"
      @allowance_claim_transaction.update_attributes(:status=>2, :description=> params[:description], :approval_date => Date.today)
      redirect_to allowance_claim_transactions_path
      
    elsif decision == "revision"
      @allowance_claim_transaction.update_attributes(:status=>3, :description=> params[:description], :approval_date => Date.today)
      redirect_to allowance_claim_transactions_path  
    else
      #looking for total nominal by allowance_id
      #AllowanceClaimTransaction.where(:allowance_id => params[:allowance_id], :status => true, :approval_date => "#{Time.now.year}-01-01".."#{Time.now.year}-12-31")

      allowance_claim_transaction = AllowanceClaimTransaction.where(:allowance_id => params[:allowance_id], :status => true, :approval_date=> "#{Time.now.year}-01-01".."#{Time.now.year}-12-31" )
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

  private
    def get_allowance_detil
     @@allowance = Allowance.where(:user_id=>current_user.id).collect{|a| [a.allowance_sub_category.try(:name), a.try(:id)]}
     @allowance = current_user.allowances.map{|a| [a.allowance_sub_category.try(:name), a.try(:id)]}

     @allowance_categories = Allowance.where(:user_id=>current_user).collect{|a| [a.allowance_sub_category.allowance_category.try(:name), a.try(:id)]}
    end

    def get_history


        #@allowance_claim_transaction_approved = AllowanceClaimTransaction.where(:allowance_id => current_user.allowances, :status => 1, :approval_date=> "#{Time.now.year}-01-01".."#{Time.now.year}-12-31" ).order("submission_date desc")
        @allowance_claim_transaction_approved = AllowanceClaimTransaction.search_approved(params[:search_approved], params[:search_approved_by], current_user)
        @allowance_claim_transaction_rejected = AllowanceClaimTransaction.search_rejected(params[:search_rejected], params[:search_rejected_by], current_user)
        @allowance_claim_transaction_pending = AllowanceClaimTransaction.search_pending(params[:search_pending], params[:search_pending_by], current_user)
        @allowance_claim_transaction_revisi = AllowanceClaimTransaction.search_revision(params[:search_revision], params[:search_revision_by], current_user)
      
      
    end
end
