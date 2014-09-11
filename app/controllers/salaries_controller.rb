
class SalariesController < ApplicationController
  # GET /salaries
  # GET /salaries.json
  def index
    @salaries = Salary.all

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
    # @salary = Salary.new(params[:salary])

    #get last salary
    last_salary = Salary.last

    if last_salary == nil
      # get curren date
      salaries = []
      date = Date.today.at_beginning_of_week.strftime("%y-%m-2")
      user = User.all

      user.each do | u |
        if u.salary_histories
        total_attendance = Absent.where(:user_id => u, :categories => 1).count
        total_absence = Absent.where("user_id =? AND categories <> ?", u, 1).count
        total_overtime_hours = u.overtimes.sum(:long_overtime)
        total_overtime_payment  = total_overtime_hours * u.overtime_pay
        salary_history_id = u.salary_histories.where(activate: true).select("id").first.id
        
        # ccc = salary_history_id.select("id")
        # p ccc
        p "====="
        p @salary
        p "================"
        
        # @salary.save!

        salaries << {date: date, total_attendance: total_attendance, total_absence: total_absence, 
          total_overtime_hours: total_overtime_hours, total_overtime_payment: total_overtime_payment, 
          salary_history_id: salary_history_id }
        
        end
        @salaries = Salary.new(salaries)
# @salaries .save

      end
    end

    




    # respond_to do |format|
    #   if @salary.save
    #     format.html { redirect_to @salary, notice: 'Salary was successfully created.' }
    #     format.json { render json: @salary, status: :created, location: @salary }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @salary.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PUT /salaries/1
  # PUT /salaries/1.json
  def update
    @salary = Salary.find(params[:id])

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

  # <div class="wrapeer-salary" id="nested-salary">
  #  <%= f.fields_for :salary do |builder| %> <%= render "salary_fields", :f => builder %> <% end %> </div>

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
