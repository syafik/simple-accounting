class LoanPaymentsController < ApplicationController
  before_filter :get_loan_detil, only: [:new, :edit]
  # GET /loan_payments
  # GET /loan_payments.json
  def index
    if current_user.role_id == 2
      @loan_permissions = LoanPermission.where(:status => 3)
    else
      @loan_permissions = LoanPermission.where(:status => 3, :user_id => current_user.id)
    end
    @loan_payments = LoanPayment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @loan_payments }
    end
  end

  # GET /loan_payments/1
  # GET /loan_payments/1.json
  def show
    @loan_payment = LoanPayment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @loan_payment }
    end
  end

  # GET loan detil
  def get_loan_detil
    loan_permission_id = params[:id]
    @loan_permission = LoanPermission.find(loan_permission_id)
    get_loan_id =  LoanPayment.where(:loan_permission_id => loan_permission_id)
    if current_user.role_id == 2
      @loan_payment_history = get_loan_id.where(:status => 0)
    else
      @loan_payment_history = {approveds: get_loan_id.where(:status => 1), rejecteds: get_loan_id.where(:status => 2)}
    end
  end

  # approval payment
  def set_approval
    @loan_payment = LoanPayment.find(params[:id])
    #cek status
    p decision = params[:decision]
    if decision == "rejected"
      @loan_payment.update_attributes(:status=>2, :description=> params[:description], :approval_date => Date.today)
    elsif decision == "approved"
      @loan_payment.update_attributes(:status=>1, :description=> params[:description], :approval_date => Date.today)
    end
  end

  # GET /loan_payments/new
  # GET /loan_payments/new.json
  def new

    # get loan detil

    @loan_payment = LoanPayment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @loan_payment }
    end
  end

  # GET /loan_payments/1/edit
  def edit
    # get loan detil

    # @loan_payment = LoanPayment.find(params[:id])
  end

  # POST /loan_payments
  # POST /loan_payments.json
  def create
    @loan_payment = LoanPayment.new(params[:loan_payment])
    loan_permission_id = params[:loan_payment][:loan_permission_id]
    @loan_permission = LoanPermission.find(loan_permission_id)
    
    paid = LoanPayment.get_paid(loan_permission_id,  params[:loan_payment][:total_payment].to_f)
    p "======"
    p paid
    

    respond_to do |format|
      if paid <= @loan_permission.total_loan &&  @loan_payment.save
        format.html { redirect_to @loan_payment, notice: 'Loan payment was successfully created.' }
        format.json { render json: @loan_payment, status: :created, location: @loan_payment }
      else
        format.html { render action: "new" }
        format.json { render json: @loan_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /loan_payments/1
  # PUT /loan_payments/1.json
  def update
    @loan_payment = LoanPayment.find(params[:id])

    respond_to do |format|
      if @loan_payment.update_attributes(params[:loan_payment])
        format.html { redirect_to @loan_payment, notice: 'Loan payment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @loan_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loan_payments/1
  # DELETE /loan_payments/1.json
  def destroy
    @loan_payment = LoanPayment.find(params[:id])
    @loan_payment.destroy

    respond_to do |format|
      format.html { redirect_to loan_payments_url }
      format.json { head :no_content }
    end
  end
end
