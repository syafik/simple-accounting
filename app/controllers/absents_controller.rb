class AbsentsController < ApplicationController
  before_filter :get_user, :only => [:new, :create, :edit, :update]
  before_filter :get_absent, :only => [:index, :set_attend]
  before_filter :check_date, :only => [:create]

  # GET /absents
  # GET /absents.json
  def index
    @date = Date.today
    if params[:search]
      @date = params[:search].to_date
      @absents= Absent.where(date: params[:search]).order("date desc")
    else
      @absents= Absent.where(date: Date.today).order("date desc")
    end
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

    if params[:absent][:time_in] && params[:absent][:time_out]
      params[:absent][:time_in] = Time.parse(params[:absent][:time_in]).strftime("%H:%M:%S") rescue nil
      params[:absent][:time_out] = Time.parse(params[:absent][:time_out]).strftime("%H:%M:%S") rescue nil
    end
    @absent = Absent.new(params[:absent])
    @absent.total_work_time = Absent.get_total_work_time(@absent.time_in, @absent.time_out) rescue nil
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

    if params[:absent][:time_in] && params[:absent][:time_out]
      params[:absent][:time_in] = Time.parse(params[:absent][:time_in]).strftime("%H:%M:%S") rescue nil
      params[:absent][:time_out] = Time.parse(params[:absent][:time_out]).strftime("%H:%M:%S") rescue nil
      params[:absent][:total_work_time] =Absent.get_total_work_time(Time.parse(params[:absent][:time_in]), Time.parse(params[:absent][:time_out]) )
    end

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
    p '= set_attend' * 66
    p params
    if @check_absent.blank?
      absent = Absent.create(user_id: current_user.id, time_in: Time.current.strftime("%H:%M:%S"), date: Time.current.to_date, categories: 1)
      if absent.save!
        redirect_to absents_path
      end
    else
      # still bug because time.now.min => using 24 but from databas using am pm
      total_work_time = Absent.get_total_work_time(@check_absent.time_in, Time.parse(Time.current.strftime("%H:%M:%S")))
      if @check_absent.update_attributes(time_out: Time.current.strftime("%H:%M:%S"), total_work_time: total_work_time)
        redirect_to absents_path
      else
        redirect_to absents_path
      end
    end

  end


  private
  def get_user
    @users = User.all.map {|user| [user.email, user.id]}
  end

  def get_absent
    @check_absent = current_user.absents.where({categories: 1, date: Date.today}).first
  end

  def check_date
    if params[:absent][:date].is_a?(String)
      params[:absent][:date] = DateTime.strptime(params[:absent][:date], "%m/%d/%Y").to_date
    end
  end
end
