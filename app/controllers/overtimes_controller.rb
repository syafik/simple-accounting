class OvertimesController < ApplicationController
  load_and_authorize_resource

	before_filter :get_user, :only => [:index, :new, :create, :edit, :update]
	before_filter :check_date, :only => [:create]
  # GET /overtimes
  # GET /overtimes.json
  def index
    @current_time = Date.today
    year = params[:year] || @current_time.year
    month = params[:month] || @current_time.month
    @date = DateTime.new(year.to_i,month.to_i, 1)
    @next = @date + 1.month
    @prev = @date - 1.month
    @start_date = @date.beginning_of_month
    @end_date = @date.end_of_month

    @overtimes = Overtime.where(:date => @start_date..@end_date).order('date ASC')

    if current_user.role_id==2
        if params[:user_id]
          @overtimes = @overtimes.where(user_id: params[:user_id])
        else
          @overtimes = @overtimes
        end
  		
  	else
  		@overtimes = Overtime.where(:user_id => current_user.id)
  	end


  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @overtimes }
    end
  end

  # GET /overtimes/1
  # GET /overtimes/1.json
  def show
  	@overtime = Overtime.find(params[:id])

  	respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @overtime }
    end
  end

  # GET /overtimes/new
  # GET /overtimes/new.json
  def new
  	@overtime = Overtime.new


  	respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @overtime }
    end
  end

  # GET /overtimes/1/edit
  def edit
  	@overtime = Overtime.find(params[:id])
  end

  # POST /overtimes
  # POST /overtimes.json
  def create
  	@overtime = Overtime.new(params[:overtime])
  	user = User.find(@overtime.user_id)

  	@overtime.long_overtime = Overtime.long_overtime(@overtime.start_time, @overtime.end_time)
  	total_long_overtime = Overtime.total_long_overtime(user, @overtime.long_overtime)
  	@overtime.day_payment = Overtime.day_payment_overtime(@overtime.start_time, @overtime.end_time, user)
  	@overtime.night_payment = Overtime.night_payment_overtime(@overtime.start_time, @overtime.end_time, user)
  	@overtime.payment = @overtime.day_payment + @overtime.night_payment
    @overtime.status = 0

  	respond_to do |format|
  		if total_long_overtime <= Setting[:maxovertimeperday].to_f  && @overtime.save
  			format.html { redirect_to @overtime, notice: 'Overtime was successfully created.' }
  			format.json { render json: @overtime, status: :created, location: @overtime }
  		else
        format.html { redirect_to new_overtime_url,  :flash => { :error => "Jam Lembur Anda Melebihi 8 Jam" }}
        format.json { render json: @overtime.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /overtimes/1
  # PUT /overtimes/1.json
  def update
  	@overtime = Overtime.find(params[:id])
  	user= User.find(params[:overtime][:user_id].to_i)
  	params[:overtime][:long_overtime] = @overtime.long_overtime

  	if Time.parse(@overtime.start_time.strftime("%H:%M ")) != Time.parse(params[:overtime][:start_time]) || Time.parse(@overtime.end_time.strftime("%H:%M ")) !=Time.parse(params[:overtime][:end_time])
  		params[:overtime][:long_overtime] = Overtime.long_overtime(Time.parse(params[:overtime][:start_time]), Time.parse(params[:overtime][:end_time]))
      total_long_overtime = Overtime.total_long_overtime(user, params[:overtime][:long_overtime])
    end

    total_long_overtime = 0 

    params[:overtime][:day_payment] = Overtime.day_payment_overtime(Time.parse(params[:overtime][:start_time]), Time.parse(params[:overtime][:end_time]), user)
    params[:overtime][:night_payment] = Overtime.night_payment_overtime(Time.parse(params[:overtime][:start_time]), Time.parse(params[:overtime][:end_time]), user)
    params[:overtime][:payment] = params[:overtime][:day_payment] + params[:overtime][:night_payment]

    respond_to do |format|
      if total_long_overtime <= Setting[:maxovertimeperday].to_f && @overtime.update_attributes(params[:overtime])
       format.html { redirect_to @overtime, notice: 'Overtime was successfully updated.' }
       format.json { head :no_content }
     else
       format.html { render action: "edit" }
       format.json { render json: @overtime.errors, status: :unprocessable_entity }
     end
   end
 end

  # DELETE /overtimes/1
  # DELETE /overtimes/1.json
  def destroy
  	@overtime = Overtime.find(params[:id])
  	@overtime.destroy

  	respond_to do |format|
  		format.html { redirect_to overtimes_url }
  		format.json { head :no_content }
  	end
  end

  def set_approval
  	@overtime = Overtime.find(params[:id])
  	@overtime.update_attributes!(status: 1)
  	respond_to do |format|
      UserMailer.send_lembur_approved_user(@overtime.user).deliver
  		format.html { redirect_to overtimes_url }
  		format.json { head :no_content }
  	end
  end

  def set_rejected
  	@overtime = Overtime.find(params[:id])
  	@overtime.update_attributes!(status: 2)
  	respond_to do |format|
      UserMailer.send_lembur_rejected_user(@overtime.user).deliver
  		format.html { redirect_to overtimes_url }
  		format.json { head :no_content }
  	end
  end

  private
  def get_user
  	@users = User.all.map {|user| [user.first_name, user.id]}
  end

  def check_date

  	if  params[:overtime][:date].is_a?(String)
  		params[:overtime][:date] = DateTime.strptime(params[:overtime][:date], "%m/%d/%Y").to_date

  	end
  end
end
