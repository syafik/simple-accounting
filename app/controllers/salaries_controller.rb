class SalariesController < ApplicationController # :nodoc:
  load_and_authorize_resource

  def index
    if params[:salary_schedule].present?
      @salary_schedule = SalarySchedule.find(params[:salary_schedule])
      @salaries = @salary_schedule.salaries
      @date = @salary_schedule.try(:date)
    else
      @salaries = SalarySchedule.last.salaries rescue []
      @date = nil
    end


    respond_to do |format|
      format.html # index.html.erb
      format.xls
    end
  end

  def show
    @salary = Salary.find(params[:id])
    @total_pendapatan = @salary.salary_history.payment +  @salary.total_overtime_payment + @salary.jamsostek + @salary.transport + @salary.etc
    @total_potongan   = @total_pendapatan - @salary.thp
    @total_penerimaan = @total_pendapatan - @total_potongan

    respond_to do |format|
      format.html
      format.json { render json: @salary }
      format.pdf do
        render :pdf => "file_name"
      end
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
        format.html { redirect_to salaries_path,  :flash => { :error => "Anda Sudah Menggenerate Gaji Untuk Bulan Ini" }}
      end
    end
  end

  def update
    @salary = Salary.find(params[:id])

    params[:salary][:thp] = params[:salary][:etc].to_f + params[:salary][:total_overtime_payment].to_f + @salary.salary_history.payment +  @salary.jamsostek


    if @salary.salary_history.participate_jamsostek && @salary.salary_history.allowed_jamsostek
      params[:salary][:thp] = params[:salary][:thp] -  @salary.jamsostek
    end
    params[:salary][:thp] = params[:salary][:thp] - params[:potongan].to_f
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
        format.html { redirect_to salaries_path,  :flash => { :error => "Anda Sudah Menggenerate Gaji Untuk Bulan Ini" }}
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


  def salary
     @salaries = Salary.this_month

    respond_to do |format|
      format.html
      format.xls do
        render :xls => "file_name"
      end
      format.pdf
    end
  end

end
