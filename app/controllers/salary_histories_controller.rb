class SalaryHistoriesController < ApplicationController
  load_and_authorize_resource

  def index
    if current_user.is_admin?
      @salary_histories = SalaryHistory.where(user_id: params[:id]).order("id asc")
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
   SalaryHistory.update_all("activate = false", "id <> #{ params[:id] } AND user_id = #{@salary_history.user_id}" )
   redirect_to salary_histories_user_path(@salary_history.user_id)
  end


end
