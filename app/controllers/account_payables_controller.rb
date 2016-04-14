
class AccountPayablesController < ApplicationController # :nodoc:
  # GET /account_payables
  # GET /account_payables.json
   load_and_authorize_resource
  def index
    @account_payables = AccountPayable.where(parent_id: nil)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @account_payables }
    end
  end

  # GET /account_payables/1
  # GET /account_payables/1.json
  def show
    @account_payable = AccountPayable.find(params[:id])
    @account_payables = AccountPayable.where(parent_id: @account_payable.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account_payable }
    end
  end

  # GET /account_payables/new
  # GET /account_payables/new.json
  def new
    @account_payable = AccountPayable.new
    @credit = params[:credit].eql?("true") ? true : false


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

    params[:account_payable][:debit] = params[:account_payable][:debit].gsub(",","")
    params[:account_payable][:credit] = params[:account_payable][:credit].gsub(",","")
    p params[:account_payable][:debit]
    parent = AccountPayable.find(params[:account_payable][:parent_id]) if params[:account_payable][:parent_id]
    @account_payables = AccountPayable.where(parent_id: parent.id) if params[:account_payable][:parent_id]
    @credit = params[:credit].eql?("true") ? true : false
    @account_payable = AccountPayable.new(params[:account_payable])

    @sisa_hutang = parent.debit.to_i - @account_payables.sum(&:credit).to_i if params[:account_payable][:parent_id]
    if params[:account_payable][:parent_id] and params[:account_payable][:credit].to_i > @sisa_hutang.to_i
      flash.now[:error] = "Credit lebih besar dari debit.!"
      render action: "new", :debit => true
   else
    respond_to do |format|
      if @account_payable.save
        format.html { redirect_to account_payable_path(@account_payable.parent ? @account_payable.parent : @account_payable), notice: 'Account payable was successfully created.' }
        format.json { render json: @account_payable, status: :created, location: @account_payable }
      else
        format.html { render action: "new", :debit => true }
        format.json { render json: @account_payable.errors, status: :unprocessable_entity }
      end
    end
  end
end

  # PUT /account_payables/1
  # PUT /account_payables/1.json
  def update
    @account_payable = AccountPayable.find(params[:id])
    params[:account_payable][:debit] = params[:account_payable][:debit].gsub(",","")
    params[:account_payable][:credit] = params[:account_payable][:credit].gsub(",","")
    p params[:account_payable][:debit]

    respond_to do |format|
      if @account_payable.update_attributes(params[:account_payable])
        format.html { redirect_to account_payable_path(@account_payable.parent ? @account_payable.parent : @account_payable), notice: 'Account payable was successfully updated.' }
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
