class SalariesController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:salary_schedule].present?
      @salary_schedule = SalarySchedule.find(params[:salary_schedule])
      @salaries = Salary.where(date: @salary_schedule.date)
      @date = @salary_schedule.try(:date)
    else
      @salaries = Salary.this_month
      @date = nil
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @salaries }
    end
  end

  def show
    @salary = Salary.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @salary }
    end
  end

  def new
    @salary = Salary.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @salary.build }
    end
  end

  def edit
    @salary = Salary.find(params[:id])
  end

  def create
    @salary_schedule = SalarySchedule.find(params[:salary_schedule])
    @date = @salary_schedule.date if @salary_schedule.present?
    respond_to do |format|
      if @salary_schedule.present? && (@date - 2.days) == Date.today || (@date - 1.days) == Date.today
        Salary.generate_salary(@salary_schedule)
        format.html { redirect_to salaries_path(salary_schedule: @salary_schedule.id), notice: 'Gaji Untuk Bulan Ini Sudah Terkalkulasi.' }
      else
        @date
        format.html { redirect_to salaries_path(),  :flash => { :error => "Generate Gagal" }}
      end
    end
  end

  def update
    @salary = Salary.find(params[:id])
    jamsostek = 0
    if @salary.salary_history.user.allowed_jamsostek == false
      jamsostek = salary.salary_history.payment * (Setting[:jamsostek].to_f/100)
    end

    params[:salary][:thp] = params[:salary][:etc].to_f + @salary.salary_history.payment + @salary.total_overtime_payment + jamsostek

    respond_to do |format|
      if @salary.update_attributes(params[:salary])
        format.html { redirect_to @salary, notice: 'Salary was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @salary.errors, status: :unprocessable_entity }
      end
    end
  end

  def transfered
    @salary = Salary.find(params[:id])
    @salary.update_attributes(transfered: true)
    transaction = Transaction.new(date: Date.today, value: @salary.thp, is_debit: true, description: "terkirim")

    respond_to do |format|
      if transaction.save
        format.html { redirect_to salaries_path, notice: 'Sudah Terkirim' }
      else
        format.html { redirect_to salaries_path,  :flash => { :error => "GAGAL" }}
      end
    end
  end


  def destroy
    @salary = Salary.find(params[:id])
    @salary.destroy

    respond_to do |format|
      format.html { redirect_to salaries_url }
      format.json { head :no_content }
    end
  end
end
