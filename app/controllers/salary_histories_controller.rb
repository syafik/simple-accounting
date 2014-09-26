class SalaryHistoriesController < ApplicationController
  before_filter :check_date, :only => [:create]
  
  def index
    if current_user.role_id == 2
      @salary_histories = SalaryHistory.where(user_id: params[:user_id]).order("id asc")
    else
      @salary_histories = SalaryHistory.where(user_id: current_user.id)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @salary_histories }
    end
  end

  def show
    @salary_history = SalaryHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @salary_history }
    end
  end

  def new
    @salary_history = SalaryHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @salary_history }
    end
  end

  def edit
    @salary_history = SalaryHistory.find(params[:id])
  end

  def create


    @salary_history = SalaryHistory.new(params[:salary_history])
    
    # save to overtime payment hitsory
    overtime_payment_history = {applicable_date:  params[:salary_history][:applicable_date], day_payment: params[:overtime_day_payment], night_payment: params[:overtime_night_payment], user_id: current_user.id, activate: true}

    respond_to do |format|
      if @salary_history.save && OvertimePaymentHistory.create(overtime_payment_history)
        format.html { redirect_to @salary_history, notice: 'Salary history was successfully created.' }
        format.json { render json: @salary_history, status: :created, location: @salary_history }
      else
        format.html { render action: "new" }
        format.json { render json: @salary_history.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    @salary_history = SalaryHistory.find(params[:id])

    respond_to do |format|
      if @salary_history.update_attributes(params[:salary_history])
        format.html { redirect_to @salary_history, notice: 'Salary history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @salary_history.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @salary_history = SalaryHistory.find(params[:id])
    @salary_history.destroy
    set_last_active = SalaryHistory.where(user_id: @salary_history.user_id).last.update_attributes(activate: true)

    respond_to do |format|
      format.html { redirect_to salary_histories_path(user_id: @salary_history.user_id) }
      format.json { head :no_content }
    end
  end

# method for activation salary
def set_activation
 @salary_history = SalaryHistory.find(params[:id])
 @salary_history.update_attributes(:activate => true)
 p "====="
 p params
 

 #  how to update collect on rails
 # SalaryHistory.where("id <> ?", params[:format]).update_all(activate: false)
 SalaryHistory.update_all("activate = false", "id <> #{ params[:id] } AND user_id = #{@salary_history.user_id}" )
 redirect_to salary_histories_path(user_id: @salary_history.user_id)
end

def get_user
  # @users = User.all.map {|user| [user.email, user.id]}
  # @user_id = params[:id]
end

private
def check_date

  if  params[:salary_history][:applicable_date].is_a?(String)
    params[:salary_history][:applicable_date] = DateTime.strptime(params[:salary_history][:applicable_date], "%m/%d/%Y").to_date
    
  end
end

end
