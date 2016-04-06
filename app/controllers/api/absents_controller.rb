
class Api::AbsentsController < ApplicationController
  skip_before_filter :authenticate_user!, :verify_authenticity_token
  before_filter :authenticate_api
  before_filter :get_absent, :only => [:create]
  respond_to :json

  def create
    time_in = Time.zone.now
    time_out = Time.zone.now
    if @check_absent.blank?
      absent = current_user_api.absents.build(:date => time_in.to_date, :categories => 1, :time_in => Time.zone.now.strftime("%H:%M:%S"))
      if absent.save!
        render :status=>200, :json=>{:message=>"Success"}
      else
        render :status=>401, :json=>{:message=>"Failed"}
      end
    else
      render :status=>401, :json=>{:message=>"Kamu sudah absent"}
    end
  end

  private
  def get_absent
    @check_absent = current_user_api.absents.where({categories: 1, date: Date.today}).first
  end

end
