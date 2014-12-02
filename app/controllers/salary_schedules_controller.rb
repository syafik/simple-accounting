class SalarySchedulesController < ApplicationController
  load_and_authorize_resource

  def index
    @salary_schedules = SalarySchedule.all
    respond_to do |format|
      format.html
      format.json { render json: @salary_schedules }
    end
  end

  def show
    @salary_schedule = SalarySchedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @salary_schedule }
    end
  end

  def new
    @salary_schedule = SalarySchedule.new

    respond_to do |format|
      format.html
      format.json { render json: @salary_schedule }
    end
  end

  def edit
    @salary_schedule = SalarySchedule.find(params[:id])
  end

  def create
    @salary_schedule = SalarySchedule.new(params[:salary_schedule])
    respond_to do |format|
      if @salary_schedule.save
        format.html { redirect_to @salary_schedule, notice: 'Salary schedule was successfully created.' }
      else
        format.html { redirect_to new_salary_schedule_path, :flash => { :error => @salary_schedule.errors.full_messages } }
      end
    end
  end

  def update
    @salary_schedule = SalarySchedule.find(params[:id])
    @salary_schedule.end_date = params[:salary_schedule][:date]
    respond_to do |format|
      if @salary_schedule.update_attributes(params[:salary_schedule])
        format.html { redirect_to @salary_schedule, notice: 'Salary schedule was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @salary_schedule = SalarySchedule.find(params[:id])
    @salary_schedule.destroy

    respond_to do |format|
      format.html { redirect_to salary_schedules_url }
      format.json { head :no_content }
    end
  end

  def list_salary
    @users = User.all

    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "file_name"
      end
      format.xls
    end
  end

end
