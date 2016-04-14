
class AccountReceivablesController < ApplicationController # :nodoc:
  # GET /account_receivables
  # GET /account_receivables.json
  load_and_authorize_resource

  def index
    @account_receivables = AccountReceivable.where(parent_id: nil).
    group("borrower_id").
    select("account_receivables.*, sum(credit) as total, coalesce(rel.xbayar, 0) as xbayar, coalesce(sum(credit), 0) - coalesce(rel.xbayar, 0) as sisa").
    joins("LEFT JOIN (select rel.borrower_id, coalesce(SUM(rel.debit), 0) as xbayar from account_receivables rel WHERE rel.parent_id IS NOT NULL
      GROUP BY rel.borrower_id) rel ON account_receivables.borrower_id=rel.borrower_id").where("account_receivables.parent_id IS NULL").group("borrower_id").order('sisa DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @account_receivables }
    end
  end

  # GET /account_receivables/1
  # GET /account_receivables/1.json
  def show
    @account_receivable = AccountReceivable.find(params[:id])
    @account_receivables = AccountReceivable.where(parent_id: @account_receivable.id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account_receivable }
    end
  end

  # GET /account_receivables/new
  # GET /account_receivables/new.json
  def new
    @account_receivable = AccountReceivable.new
    @debit = params[:debit].eql?("true") ? true : false

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

    params[:account_receivable][:credit] = params[:account_receivable][:credit].gsub(",","")
    params[:account_receivable][:debit] = params[:account_receivable][:debit].gsub(",","")
    p params[:account_receivable][:credit]
    parent = AccountReceivable.find(params[:account_receivable][:parent_id]) if params[:account_receivable][:parent_id]
    @account_receivables = AccountReceivable.where(parent_id: parent.id) if params[:account_receivable][:parent_id]
    @debit = params[:debit].eql?("true") ? true : false
    @account_receivable = AccountReceivable.new(params[:account_receivable])

    @sisa = parent.credit.to_i - @account_receivables.sum(&:debit).to_i if params[:account_receivable][:parent_id]



    if params[:account_receivable][:parent_id] and params[:account_receivable][:debit].to_i > @sisa.to_i
      flash.now[:error] = "Debit lebih besar dari credit.!"
      render action: "new", :credit => true
    else
      respond_to do |format|
        if @account_receivable.save

          format.html { redirect_to account_receivable_path(@account_receivable.parent ? @account_receivable.parent : @account_receivable), notice: 'Account receivable was successfully created.' }
          format.json { render json: @account_receivable, status: :created, location: @account_receivable }
        else
          format.html { render action: "new" }
          format.json { render json: @account_receivable.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /account_receivables/1
  # PUT /account_receivables/1.json
  def update
    @account_receivable = AccountReceivable.find(params[:id])
    params[:account_receivable][:credit] = params[:account_receivable][:credit].gsub(",","")
    params[:account_receivable][:debit] = params[:account_receivable][:debit].gsub(",","")

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

  def users
    @account_receivables = AccountReceivable.where(borrower_id: params[:account_receivable_id]).
    select("account_receivables.*, credit as total, coalesce(rel.bayar,0) as xbayar, credit - coalesce(rel.bayar, 0) as sisa").
    joins("left JOIN (select rel.parent_id, SUM(rel.debit) as bayar
            FROM account_receivables rel
              WHERE rel.parent_id IS NOT NULL AND borrower_id = #{params[:account_receivable_id]}
                GROUP BY rel.parent_id) rel ON  account_receivables.id = rel.parent_id").where("account_receivables.parent_id IS NULL")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @account_receivables }
    end
  end

  def detail
    @user = User.find(params[:account_receivable_id])
    @total_utang =  @user.borrowers.sum(&:credit)
    @total_bayar =  @user.borrowers.sum(&:debit)
    @sisa =  @total_utang - @total_bayar
    @account_receivables = @user.borrowers.order("date ASC")
  end
end
