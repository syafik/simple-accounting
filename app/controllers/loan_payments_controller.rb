
class LoanPaymentsController < ApplicationController
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

  # GET /loan_payments/new
  # GET /loan_payments/new.json
  def new
    @loan_permission = LoanPermission.find(params[:id])
    @loan_payment = LoanPayment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @loan_payment }
    end
  end

  # GET /loan_payments/1/edit
  def edit
    @loan_payment = LoanPayment.find(params[:id])
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
