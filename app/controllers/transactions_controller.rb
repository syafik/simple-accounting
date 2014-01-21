class TransactionsController < ApplicationController

  def index
    
#    if params[:page]
#      if params[:page]
#        prev_month = params[:page].to_i
#        start_date = Time.now.beginning_of_month - (prev_month.to_i.month - 1.month)
#        end_date = Time.now.end_of_month - (prev_month.to_i.month - 1.month)
#        @transactions = Transaction.where(:date => start_date..end_date)
#        @value = prev_month - 1
#      else
#        next_month = params[:page].to_i
#        start_date = Time.now.beginning_of_month + next_month.to_i.month
#        end_date = Time.now.end_of_month + next_month.to_i.month
#        @transactions = Transaction.where(:date => start_date..end_date)
#        @value = next_month + 1
#
#      end
#      @total_debit = @transactions.debits.sum(:value)
#        @total_credit = @transactions.credits.sum(:value)
#
#    else
#      @value = 1
#      @transactions = Transaction.this_month
#      @total_debit = Transaction.this_month.debits.sum(:value)
#      @total_credit = Transaction.this_month.credits.sum(:value)
#    end

@current_time = Date.today
year = params[:year] || @current_time.year
month = params[:month] || @current_time.month
day = params[:day] || @current_time.day #9
@date = DateTime.new(year.to_i,month.to_i, 1)
@next = @date + 1.month
@prev = @date - 1.month
@start_date = @date.beginning_of_month
@end_date = @date.end_of_month


#    if(@value == 1) #current
#      session[:tmp_val]= @value #1
#    elsif(session[:tmp_val] > @value) #prev
#      session[:tmp_val]= session[:tmp_val] - 1
#      start_date = start_date + @value.month
#      end_date = end_date + @value.month
#    elsif(session[:tmp_val] < @value) # next
#
#      session[:tmp_val]= session[:tmp_val] + 1
#      p start_date = start_date + @value.month
#      p end_date = end_date + @value.month
#      aasdasd
#    end
    
   @transactions = Transaction.where(:date => @start_date..@end_date).order('date ASC ,created_at ASC')

    # if params[:page] == 1
#        prev_month = params[:page].to_i
#        start_date = Time.now.beginning_of_month - (prev_month.to_i.month - 1.month)
#        end_date = Time.now.end_of_month - (prev_month.to_i.month - 1.month)
#        @transactions = Transaction.where(:date => start_date..end_date)
##        @value = prev_month - 1
#      else
#        next_month = params[:page].to_i
#        start_date = Time.now.beginning_of_month + next_month.to_i.month
#        end_date = Time.now.end_of_month + next_month.to_i.month
#        @transactions = Transaction.where(:date => start_date..end_date)
##        @value = next_month + 1
#
#      end
         @total_debit = @transactions.debits.sum(:value)
        @total_credit = @transactions.credits.sum(:value)
        @profit = @total_debit -  @total_credit

                
    #        @lose = @total_credit - @total_debit
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
        format.html { redirect_to @transaction, notice: 'Test was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
end


def reporting
  Transaction.where("extract(year  from date) = ? AND extract(month from date) = ?", "%Y", "%B")
 end

end
