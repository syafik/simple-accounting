class AllowanceClaimTransactionsController < ApplicationController
  load_and_authorize_resource

	before_filter :get_allowance_detil
  before_filter :get_history,  :only => [:new, :create] 
  before_filter :get_sub_category, :only => [:index, :new]

  def index
  # p params[:search]
  #   @allowance_claim_transaction = {
  #     approveds: AllowanceClaimTransaction.search_approved(params[:search_approved], params[:search_approved_by], current_user, "index",params[:from_approved],params[:to_approved]).paginate(:page => params[:page], :per_page => 5),
  #     rejecteds: AllowanceClaimTransaction.search_rejected(params[:search_rejected], params[:search_rejected_by], current_user, "index",params[:from_rejected],params[:to_rejected]).paginate(:page => params[:page], :per_page => 5),
  #     pendings: AllowanceClaimTransaction.search_pending(params[:search_pending], params[:search_pending_by], current_user, "index",params[:from_pending],params[:to_pending]).paginate(:page => params[:page], :per_page => 1),
  #     revisions: AllowanceClaimTransaction.search_revision(params[:search_revision], params[:search_revision_by], current_user, "index",params[:from_revision],params[:to_revision]).paginate(:page => params[:page], :per_page => 5)}

  if current_user.role == "admin"
        @allowance_claim_transactions = AllowanceClaimTransaction.admin_search(params[:search],current_user)#.paginate(:page => params[:page], :per_page => 1)
        p "controller"
        p @allowance_claim_transactions
      end
    end

    def new
     @allowance_claim_transaction = AllowanceClaimTransaction.new


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
    AllowanceClaimTransaction.approval
  end

  private
  def get_allowance_detil
   @@allowance = Allowance.where(:user_id=>current_user.id).collect{|a| [a.allowance_sub_category.try(:name), a.try(:id)]}
   @allowance = current_user.allowances.map{|a| [a.allowance_sub_category.try(:name), a.try(:id)]}
   @allowance_categories = Allowance.where(:user_id=>current_user).collect{|a| [a.allowance_sub_category.allowance_category.try(:name), a.try(:id)]}
  end

  def get_history
    @get_allowance_claim_transaction = AllowanceClaimTransaction.user_search(params[:search],current_user)#.paginate(:page => params[:page], :per_page => 1)
  end

  def get_sub_category
    @allowance_sub_category = AllowanceSubCategory.all.map { |allowance_sub_category| [allowance_sub_category.name, allowance_sub_category.id]}
  end
end
