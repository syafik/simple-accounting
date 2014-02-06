class TransactionsController < ApplicationController

  def index
    @current_time = Date.today
    year = params[:year] || @current_time.year
    month = params[:month] || @current_time.month
    day = params[:day] || @current_time.day #9
    @date = DateTime.new(year.to_i,month.to_i, 1)
    @next = @date + 1.month
    @prev = @date - 1.month
    @start_date = @date.beginning_of_month
    @end_date = @date.end_of_month
    @transactions = Transaction.where(:date => @start_date..@end_date).order('date ASC ,created_at ASC')
    @total_debit = @transactions.debits.sum(:value)
    @total_credit = @transactions.credits.sum(:value)
    @profit = @total_debit -  @total_credit
  end

  def new
    @debit = Transaction.new
    @credit = Transaction.new
    @current_time = Transaction.new
  end

  def create
    @debit = Transaction.new(params[:transaction])
    @debit.is_debit = true
    respond_to do |format|
      if @debit.save
        format.html { redirect_to transactions_path }
        format.js
      else
        format.html { render action: "new" }
      end
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_path }
      format.json { head :no_content }
    end
  end
  
  def credit
    @new_credit = Transaction.new(params[:transaction])
    #Transaction.new({:value => 1, :date => date}) sama dengan params yang diatas
    respond_to do |format|
      if @new_credit.save
        # save! rise error menampilkan error di aplikasi (hanyak untuk development)
        # save tidak menampilkan error tapi bakal menampilkan error di form
        format.html { redirect_to transactions_path }
      else
        format.html { render action: "new_credit" }
      end
    end
  end

  def new_credit
    @new_credit = Transaction.new(params[:transaction])
  end

  def edit
    @transaction = Transaction.find(params[:id])
  end

 def update
  @transaction = Transaction.find(params[:id])

  respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to  transactions_path, notice: 'successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

end
