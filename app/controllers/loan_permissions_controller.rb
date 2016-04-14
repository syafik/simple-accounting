class LoanPermissionsController < ApplicationController # :nodoc:
  load_and_authorize_resource

  before_filter :get_history,  :only => [:new, :create]

  # GET /loan_permissions
  # GET /loan_permissions.json
  def index
    @loan_permissions = LoanPermission.admin_search(params[:search],current_user)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @loan_permissions }
    end
  end

  # GET /loan_permissions/1
  # GET /loan_permissions/1.json
  def show
    @loan_permission = LoanPermission.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @loan_permission }
    end
  end

  # GET /loan_permissions/new
  # GET /loan_permissions/new.json
  def new
    @loan_permission = LoanPermission.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @loan_permission }
    end
  end

  # GET /loan_permissions/1/edit
  def edit
    @loan_permission = LoanPermission.find(params[:id])
  end

  # POST /loan_permissions
  # POST /loan_permissions.json
  def create
    @loan_permission = LoanPermission.new(params[:loan_permission])

    respond_to do |format|
      if @loan_permission.save
        format.html { redirect_to @loan_permission, notice: 'Loan permission was successfully created.' }
        format.json { render json: @loan_permission, status: :created, location: @loan_permission }
      else
        format.html { render action: "new" }
        format.json { render json: @loan_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /loan_permissions/1
  # PUT /loan_permissions/1.json
  def update
    @loan_permission = LoanPermission.find(params[:id])

    respond_to do |format|
      if @loan_permission.update_attributes(params[:loan_permission])
        format.html { redirect_to @loan_permission, notice: 'Loan permission was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @loan_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loan_permissions/1
  # DELETE /loan_permissions/1.json
  def destroy
    @loan_permission = LoanPermission.find(params[:id])
    @loan_permission.destroy

    respond_to do |format|
      format.html { redirect_to loan_permissions_url }
      format.json { head :no_content }
    end
  end

  def set_approval
    @loan_permission = LoanPermission.find(params[:id])
    #cek status
    p decision = params[:decision]



    if decision == "rejected"
      @loan_permission.update_attributes(:status=>2, :description=> params[:description], :approval_date => Date.today)
    elsif decision == "approved"

      @loan_permission.update_attributes(:status=>1, :description=> params[:description], :approval_date => Date.today)
    end

    redirect_to loan_permissions_path



  end

  def set_taken

    @loan_permission = LoanPermission.find(params[:id])
    @loan_permission.update_attributes(:status=>3)
    redirect_to new_loan_permission_path
  end

  def set_decline
    @loan_permission = LoanPermission.find(params[:id])
    @loan_permission.update_attributes(:status=>4)
  end

  private
  def get_history
    @get_laon_permissions = LoanPermission.user_search(params[:search],current_user)
    p @get_laon_permissions

  end
end
