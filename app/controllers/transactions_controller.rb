class TransactionsController < ApplicationController

  def index
    @current_time = Date.today
    year = params[:year] || @current_time.year
    month = params[:month] || @current_time.month
    day = params[:day] || @current_time.day
    @date = DateTime.new(year.to_i, month.to_i, 1)
    @next = @date + 1.month
    @prev = @date - 1.month
    @start_date = @date.beginning_of_month
    @end_date = @date.end_of_month
    @transactions = Transaction.where(:date => @start_date..@end_date).order('date DESC')
    @total_debit = @transactions.debits.sum(:value)
    @total_credit = @transactions.credits.sum(:value)
    @profit = @total_debit -  @total_credit
  end

  def new
    @transaction = Transaction.new
    @is_debit = params[:debit].present? ? true : false
    respond_to do |format|
      format.js
    end
  end

  def create
    @transaction = Transaction.new(params[:transaction])
    @transaction.value = params[:transaction][:value].delete(',').to_i
    @is_saved = @transaction.save
    @error_msg = @transaction.errors.full_messages
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_path }
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @transaction = Transaction.find(params[:id])
    params[:transaction][:value] = params[:transaction][:value].delete(',').to_i
    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to  transactions_path, notice: 'successfully updated.' }
      else
        format.html { redirect_to  transactions_path, alert: @transaction.errors.full_messages }
      end
    end
  end

end
