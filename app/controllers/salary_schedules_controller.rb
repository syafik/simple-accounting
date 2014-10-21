class SalarySchedulesController < ApplicationController
  load_and_authorize_resource

  before_filter :check_date, :only => [:create, :update]
  # GET /salary_schedules
  # GET /salary_schedules.json
  def index
    @salary_schedules = SalarySchedule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @salary_schedules }
    end
  end

  # GET /salary_schedules/1
  # GET /salary_schedules/1.json
  def show
    @salary_schedule = SalarySchedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @salary_schedule }
    end
  end

  # GET /salary_schedules/new
  # GET /salary_schedules/new.json
  def new
    @salary_schedule = SalarySchedule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @salary_schedule }
    end
  end

  # GET /salary_schedules/1/edit
  def edit
    @salary_schedule = SalarySchedule.find(params[:id])
  end

  # POST /salary_schedules
  # POST /salary_schedules.json
  def create
    @salary_schedule = SalarySchedule.new(params[:salary_schedule])

    respond_to do |format|
      if @salary_schedule.save
        format.html { redirect_to @salary_schedule, notice: 'Salary schedule was successfully created.' }
        format.json { render json: @salary_schedule, status: :created, location: @salary_schedule }
      else
        format.html { render action: "new" }
        format.json { render json: @salary_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /salary_schedules/1
  # PUT /salary_schedules/1.json
  def update
    @salary_schedule = SalarySchedule.find(params[:id])

    respond_to do |format|
      if @salary_schedule.update_attributes(params[:salary_schedule])
        format.html { redirect_to @salary_schedule, notice: 'Salary schedule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @salary_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /salary_schedules/1
  # DELETE /salary_schedules/1.json
  def destroy
    @salary_schedule = SalarySchedule.find(params[:id])
    @salary_schedule.destroy

    respond_to do |format|
      format.html { redirect_to salary_schedules_url }
      format.json { head :no_content }
    end
  end

  private
  def check_date

    if  params[:salary_schedule][:date].is_a?(String)
      params[:salary_schedule][:date] = DateTime.strptime(params[:salary_schedule][:date], "%m/%d/%Y").to_date
    end
  end
end
