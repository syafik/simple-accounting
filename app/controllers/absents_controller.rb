
class AbsentsController < ApplicationController
  before_filter :get_user, :only => [:new, :create, :edit, :update]
  before_filter :get_absent, :only => [:index, :set_attend]

  # GET /absents
  # GET /absents.json
  def index
    @date = Date.today
    p "="*99
    p @date
    if params[:search]
      @date = params[:search].to_date
      @absents= Absent.where(date: params[:search]).order("date desc")
    else
      @absents= Absent.where(date: Date.today).order("date desc")
    end
    

    # @date = Date.today
    # year = params[:year] || @date.year
    # month = params[:month] || @date.month
    # @date = DateTime.new(year.to_i,month.to_i, 1)
    # @next = @date + 1.month
    # @prev = @date - 1.month
    # @start_date = @date.beginning_of_month
    # @end_date = @date.end_of_month


    # if current_user.role != 2
    #   # didnt work yet
    #   @absents = current_user.absents.where("extract(year from date) = #{Time.now.year} AND extract(month from date) = #{Time.now.month}").order("date desc").paginate(:page => params[:page], :per_page => 10)
    # else
    #   if params[:search]
    #     @absents =  Absent.where(user_id: params[:search])
    #   else 
    #     @absents = Absent.where("extract(year from date) = #{year} AND extract(month from date) = #{month}").order("date desc").paginate(:page => params[:page], :per_page => 10)
    #   end
    # end


    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render json: @absents }
    #   format.js
    # end
  end

  # GET /absents/1
  # GET /absents/1.json
  def show
    @absent = Absent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @absent }
    end
  end

  # GET /absents/new
  # GET /absents/new.json
  def new
    @absent = Absent.new
    
    #@absent_categories = AbsentCategory.all.map { |absent_category| [absent_category.category_name, absent_category.id] }
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @absent }
    end
  end

  # GET /absents/1/edit
  def edit
    @absent = Absent.find(params[:id])
  end

  # POST /absents
  # POST /absents.json
  def create
    params[:absent][:date] = DateTime.strptime(params[:absent][:date], "%m/%d/%Y").to_date
    @absent = Absent.new(params[:absent])
   

    respond_to do |format|
      if @absent.save
        format.html { redirect_to @absent, notice: 'Absent was successfully created.' }
        format.json { render json: @absent, status: :created, location: @absent }
      else
        format.html { render action: "new",:flash => { :error => "Insufficient rights!" } }
        format.json { render json: @absent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /absents/1
  # PUT /absents/1.json
  def update
    @absent = Absent.find(params[:id])

    respond_to do |format|
      if @absent.update_attributes(params[:absent])
        format.html { redirect_to @absent, notice: 'Absent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @absent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /absents/1
  # DELETE /absents/1.json
  def destroy
    @absent = Absent.find(params[:id])
    @absent.destroy

    respond_to do |format|
      format.html { redirect_to absents_url }
      format.json { head :no_content }
    end
  end

  def set_attend
    if @check_absent.blank?
      absent =Absent.create(user_id: current_user.id, time_in: Time.current.strftime("%H:%M:%S"), date: Time.current.to_date, categories: 1)
      # absent.time_in = Time.now.strftime("%I:%M:%S")
      if absent.save!
        redirect_to absents_path
      end
    else
      th_in = @check_absent.time_in.hour
      th_now = Time.current.hour

      tm_in = @check_absent.time_in.min
      tm_now = Time.current.min

      difh = th_now - th_in
      difm = tm_now - tm_in

      # still bug because time.now.min => using 24 but from databas using am pm
      p "="*9
      p difh
      p "="*9
      p difm

      


      if difh >= 8 && difm >=0 &&  @check_absent.update_attributes(time_out: Time.current.strftime("%H:%M:%S"), total_work_time: "#{difh}.#{difm}".to_f)
        redirect_to absents_path
      else
      end
    end
    

    # respond_to do |format|
    #   if absent.save
    #     format.html { redirect_to absent, notice: 'Absent was successfully created.' }
    #     format.json { render json: absent, status: :created, location: absent }
    #   else
    #     format.html { render action: "new",:flash => { :error => "Insufficient rights!" } }
    #     format.json { render json: absent.errors, status: :unprocessable_entity }
    #   end
    # end

  end


  private
  def get_user
    @users = User.all.map {|user| [user.email, user.id]}
  end

  def get_absent
    @check_absent = current_user.absents.where({categories: 1, date: Date.today}).first
  end
end
