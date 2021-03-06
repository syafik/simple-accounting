class AbsentsController < ApplicationController # :nodoc:
  before_filter :get_user, :only => [:new, :create, :edit, :update]
  before_filter :get_absent, :only => [:index, :set_attend]
  before_filter :check_date, :only => [:create]

  def index
    @date = Date.current
    if params[:search]
      @date = params[:search].to_date
      @absents= Absent.where(date: params[:search]).order("date desc")
    else
      @absents= Absent.where(date: Date.current).order("date desc")
    end
  end

  def summary
    @date = Date.today
    @date = params[:search].to_date if params[:search]
    year = @date.year
    month = @date.month
    @absents = User.joins("left join absents on absents.user_id = users.id AND MONTH(absents.date) = #{month} AND YEAR(absents.date) =  #{year}").
        select("users.first_name, users.last_name, count(absents.user_id) as jumlah ").group("absents.user_id")
  end

  def show
    @absent = Absent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @absent }
    end
  end

  def new
    @absent = Absent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @absent }
    end
  end

  def edit
    @absent = Absent.find(params[:id])
  end

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
        format.html { render action: "new",:flash => { :error => "insufficient rights!" } }
        format.json { render json: @absent.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @absent = Absent.find(params[:id])

    if params[:absent][:time_in] && params[:absent][:time_out]
      params[:absent][:time_in] = Time.parse(params[:absent][:time_in]).strftime("%H:%M:%S") rescue nil
      params[:absent][:time_out] = Time.parse(params[:absent][:time_out]).strftime("%H:%M:%S") rescue nil
      params[:absent][:total_work_time] = Absent.get_total_work_time(Time.parse(params[:absent][:time_in]), Time.parse(params[:absent][:time_out]) )
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
    @check_absent = current_user.absents.where({categories: 1, date: Time.zone.now.to_date}).first
  end

  def check_date
    if params[:absent][:date].is_a?(String)
      params[:absent][:date] = params[:absent][:date].to_date
    end
  end
end

#
#SELECT users.id as id, count(absents.user_id) as jumlah, absents.date FROM `users` left outer join absents on absents.user_id = users.id AND (date is null OR  YEAR(date) = 2014)
#
#GROUP BY absents.user_id
