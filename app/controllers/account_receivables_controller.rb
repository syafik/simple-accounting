
class AccountReceivablesController < ApplicationController
  # GET /account_receivables
  # GET /account_receivables.json
  load_and_authorize_resource
  
  def index
    @account_receivables = AccountReceivable.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @account_receivables }
    end
  end

  # GET /account_receivables/1
  # GET /account_receivables/1.json
  def show
    @account_receivable = AccountReceivable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account_receivable }
    end
  end

  # GET /account_receivables/new
  # GET /account_receivables/new.json
  def new
    @account_receivable = AccountReceivable.new
    @debit = params[:debit] ? true : false
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @account_receivable }
    end
  end

  # GET /account_receivables/1/edit
  def edit
    @account_receivable = AccountReceivable.find(params[:id])
  end

  # POST /account_receivables
  # POST /account_receivables.json
  def create
    @debit = params[:debit] ? true : false
    @account_receivable = AccountReceivable.new(params[:account_receivable])

    respond_to do |format|
      if @account_receivable.save
        format.html { redirect_to @account_receivable, notice: 'Account receivable was successfully created.' }
        format.json { render json: @account_receivable, status: :created, location: @account_receivable }
      else
        format.html { render action: "new" }
        format.json { render json: @account_receivable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /account_receivables/1
  # PUT /account_receivables/1.json
  def update
    @account_receivable = AccountReceivable.find(params[:id])

    respond_to do |format|
      if @account_receivable.update_attributes(params[:account_receivable])
        format.html { redirect_to @account_receivable, notice: 'Account receivable was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @account_receivable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account_receivables/1
  # DELETE /account_receivables/1.json
  def destroy
    @account_receivable = AccountReceivable.find(params[:id])
    @account_receivable.destroy

    respond_to do |format|
      format.html { redirect_to account_receivables_url }
      format.json { head :no_content }
    end
  end
end
