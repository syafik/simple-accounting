
class Api::AbsentsController < ApplicationController
  skip_before_filter :authenticate_user!, :verify_authenticity_token
  before_filter :authenticate_api
  before_filter :get_absent, :only => [:create,:index]
  before_filter :check_absent, :only => [:create]
  respond_to :json

  ## Create Absent
  # create absent
  def create
    time_in = Time.zone.now
    if $redis.get("barcodes") == params[:barcodes]
        absent = current_user_api.absents.build(:date => time_in.to_date, :categories => 1, :time_in => Time.zone.now.strftime("%H:%M:%S"))
        if absent.save!
          # render :status=>200, :json=>{:message=>"Success"}
          redirect_to api_absents_path
        else
          render :status=>401, :json=>{:message=>"Terjadi Kesalahan, Coba lagi"}
        end
    else
      render :status=>401, :json => {:message => "Terjadi Kesalahan, Coba lagi"}
    end
  end

  ## Absents Detail
  # redirect here after create
  def index
  end

  private
  def get_absent
    @check_absent = current_user_api.absents.where({categories: 1, date: Date.current}).first
  end

  def check_absent
    check_absent = current_user_api.absents.where({categories: 1, date: Date.current}).first
    if !check_absent.blank?
      redirect_to api_absents_path
    end
  end

end
