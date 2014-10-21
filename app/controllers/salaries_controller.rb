class SalariesController < ApplicationController
  load_and_authorize_resource

  # GET /salaries
  # GET /salaries.json
  def index
    if params[:date]
      @salaries = Salary.where(date: params[:date])
    else
      @salaries = Salary.all
    end
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @salaries }
    end
  end

  # GET /salaries/1
  # GET /salaries/1.json
  def show
    @salary = Salary.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @salary }
    end
  end

  # GET /salaries/new
  # GET /salaries/new.json
  def new
    @salary = Salary.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @salary.build }
    end
  end

  # GET /salaries/1/edit
  def edit
    @salary = Salary.find(params[:id])
  end

  # POST /salaries
  # POST /salaries.json
  def create
    date_salary = SalarySchedule.last
    check_date_availabel = Salary.where(date: date_salary.date)

    

    

    respond_to do |format|
      if date_salary.date == Date.today && check_date_availabel.blank?
        Salary.generate_salary
        format.html { redirect_to salaries_path, notice: 'Gaji Untuk Bulan Ini Sudah Terkalkulasi.' }
      else
        format.html { redirect_to salaries_path,  :flash => { :error => "Anda Sudah Men-generate Gaji Untuk Bulan Ini" }}
      end
    end
    

  end

  # PUT /salaries/1
  # PUT /salaries/1.json
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
      if transaction.save!
        format.html { redirect_to salaries_path, notice: 'Sudah Terkirim' }
      else
        format.html { redirect_to salaries_path,  :flash => { :error => "Anda Sudah Men-generate Gaji Untuk Bulan Ini" }}
      end
    end
  end


  # DELETE /salaries/1
  # DELETE /salaries/1.json
  def destroy
    @salary = Salary.find(params[:id])
    @salary.destroy

    respond_to do |format|
      format.html { redirect_to salaries_url }
      format.json { head :no_content }
    end
  end
end
