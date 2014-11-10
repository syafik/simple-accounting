class TransactionsController < ApplicationController
  load_and_authorize_resource

  def index
    @current_time = Date.today
    @year = params[:year] || @current_time.year
    @month = params[:month] || @current_time.month
    day = params[:day] || @current_time.day
    @date = DateTime.new(@year.to_i, @month.to_i, 1)
    @next = @date + 1.month
    @prev = @date - 1.month
    @start_date = @date.beginning_of_month
    @end_date = @date.end_of_month
    @transactions = Transaction.where(:created_at => @start_date..@end_date).order('date ASC')
    @total_debit = @transactions.debits.sum(:value)
    @total_credit = @transactions.credits.sum(:value)
    @profit = @total_debit -  @total_credit

    @is_close = TransactionSummary.where(:summary_month => @month, :summary_year => @year).empty?

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

  def close_book
    current_time = Date.today
    year = params[:year] || current_time.year
    month = params[:month] || current_time.month
    transaction_summary = TransactionSummary.where(summary_month: month, summary_year: year)
    if transaction_summary.empty?
      TransactionSummary.calculate_per_month(month, year)
      redirect_to transactions_path(:month => month, :year => year),  notice: 'Generate tutup buku berhasil.'
    else
      redirect_to transactions_path(:month => month, :year => year),  notice: 'Bulan ini sudah tutup buku.'
    end
  end

end
