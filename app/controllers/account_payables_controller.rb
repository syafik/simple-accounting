
class AccountPayablesController < ApplicationController
  # GET /account_payables
  # GET /account_payables.json
  def index
    @account_payables = AccountPayable.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @account_payables }
    end
  end

  # GET /account_payables/1
  # GET /account_payables/1.json
  def show
    @account_payable = AccountPayable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account_payable }
    end
  end

  # GET /account_payables/new
  # GET /account_payables/new.json
  def new
    @account_payable = AccountPayable.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @account_payable }
    end
  end

  # GET /account_payables/1/edit
  def edit
    @account_payable = AccountPayable.find(params[:id])
  end

  # POST /account_payables
  # POST /account_payables.json
  def create
    @account_payable = AccountPayable.new(params[:account_payable])

    respond_to do |format|
      if @account_payable.save
        format.html { redirect_to @account_payable, notice: 'Account payable was successfully created.' }
        format.json { render json: @account_payable, status: :created, location: @account_payable }
      else
        format.html { render action: "new" }
        format.json { render json: @account_payable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /account_payables/1
  # PUT /account_payables/1.json
  def update
    @account_payable = AccountPayable.find(params[:id])

    respond_to do |format|
      if @account_payable.update_attributes(params[:account_payable])
        format.html { redirect_to @account_payable, notice: 'Account payable was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @account_payable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account_payables/1
  # DELETE /account_payables/1.json
  def destroy
    @account_payable = AccountPayable.find(params[:id])
    @account_payable.destroy

    respond_to do |format|
      format.html { redirect_to account_payables_url }
      format.json { head :no_content }
    end
  end
end
