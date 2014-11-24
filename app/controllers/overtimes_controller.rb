class OvertimesController < ApplicationController
  load_and_authorize_resource
	before_filter :get_user, :only => [:index, :new, :create, :edit, :update]

  def index
    @current_time = Date.today
    year = params[:year] || @current_time.year
    month = params[:month] || @current_time.month
    @date = DateTime.new(year.to_i,month.to_i, 1)
    @next = @date + 1.month
    @prev = @date - 1.month
    @start_date = @date.beginning_of_month
    @end_date = @date.end_of_month

    if current_user.is_admin?
      if params[:user_id]
        @overtimes = Overtime.where(user_id: params[:user_id], :date => @start_date..@end_date)
      else
        @overtimes = Overtime.where(:date => @start_date..@end_date).order('date ASC')
      end
  	else
  		@overtimes = Overtime.where(:date => @start_date..@end_date, :user_id => current_user.id)
  	end

  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @overtimes }
    end
  end

  def show
  	@overtime = Overtime.find(params[:id])

  	respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @overtime }
    end
  end

  def new
  	@overtime = Overtime.new

  	respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @overtime }
    end
  end

  def edit
  	@overtime = Overtime.find(params[:id])
    @overtime.start_time = @overtime.start_time.strftime("%H:%M")
    @overtime.end_time = @overtime.end_time.strftime("%H:%M")
  end

  def create
  	@overtime = Overtime.new(params[:overtime])

  	respond_to do |format|
  		if  @overtime.save
  			format.html { redirect_to @overtime, notice: 'Overtime was successfully created.' }
  			format.json { render json: @overtime, status: :created, location: @overtime }
  		else
        format.html { render :new, :flash => { :error => @overtime.errors.full_messages.join(",") }}
        format.json { render json: @overtime.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  	@overtime = Overtime.find(params[:id])
    respond_to do |format|
      if @overtime.update_attributes(params[:overtime])
       format.html { redirect_to @overtime, notice: 'Overtime was successfully updated.' }
       format.json { head :no_content }
     else
       format.html { render action: "edit" }
       format.json { render json: @overtime.errors, status: :unprocessable_entity }
     end
   end
 end

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
  	@overtime.update_attribute("status", 1)
  	respond_to do |format|
      UserMailer.send_lembur_approved_user(@overtime.user).deliver
  		format.html { redirect_to overtimes_url }
  		format.json { head :no_content }
  	end
  end

  def set_rejected
  	@overtime = Overtime.find(params[:id])
  	@overtime.update_attribute("status", 2)
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

end
