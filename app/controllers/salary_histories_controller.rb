class SalaryHistoriesController < ApplicationController

	 def index
    @salary_histories = SalaryHistory.all

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

    respond_to do |format|
      if @salary_history.save
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

    respond_to do |format|
      format.html { redirect_to salary_histories_url }
      format.json { head :no_content }
    end
  end
end
