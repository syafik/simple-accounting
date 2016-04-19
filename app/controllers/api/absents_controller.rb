
class Api::AbsentsController < Api::ApiController
  skip_before_filter :authenticate_user!, :verify_authenticity_token
  before_filter :authenticate_api
  before_filter :get_absent, :only => [:create,:index]
  before_filter :check_absent, :only => [:create]
  respond_to :json

  ##
  # ::Absent
  # == Absent
  # method:
  #   POST
  # url:
  #   /api/absents
  # header:
  #   content-type: application/json
  #   authorization:Token token= authtentication_token
  # parameter body:
  #   {
  #     "barcodes" : "11111"
  #   }
  # response:
  # * success
  #   {
  #     "absent": {
  #       "categories": 1,
  #       "created_at": "2016-04-15T14:41:09+07:00",
  #       "date": "2016-04-15",
  #       "description": null,
  #       "id": 19,
  #       "time_in": "2000-01-01T14:41:09Z",
  #       "time_out": null,
  #       "total_work_time": null,
  #       "updated_at": "2016-04-15T14:41:09+07:00",
  #       "user_id": 2
  #     }
  #   }
  # * Failed
  #   {
  #     "message": "Terjadi Kesalahan, Coba lagi"
  #   }
  def create
    time_in = Time.zone.now
    if $redis.get("barcodes") == params[:barcodes]
        absent = current_user_api.absents.build(:date => time_in.to_date, :categories => 1, :time_in => Time.zone.now.strftime("%H:%M:%S"))
        if absent.save!
          render :status=>200, :json=>@check_absent
        else
          render :status=>404, :json=>{:message=>"Terjadi Kesalahan, Coba lagi"}
        end
    else
      render :status=>404, :json => {:message => "Terjadi Kesalahan, Coba lagi"}
    end
  end

  ##
  # ::Check Absent
  # == Check Absent
  # method:
  #   POST
  # url:
  #   /api/absents/check_absent
  # header:
  #   content-type: application/json
  #   authorization:Token token= authtentication_token
  # response:
  # * success
  #   {
  #     "absent": {
  #       "categories": 1,
  #       "created_at": "2016-04-15T14:41:09+07:00",
  #       "date": "2016-04-15",
  #       "description": null,
  #       "id": 19,
  #       "time_in": "2000-01-01T14:41:09Z",
  #       "time_out": null,
  #       "total_work_time": null,
  #       "updated_at": "2016-04-15T14:41:09+07:00",
  #       "user_id": 2
  #     }
  #   }
  # * failed
  #   {
  #     "message": "Absent Not Found"
  #   }
  def check_absent
    check_absent = current_user_api.absents.where({categories: 1, date: Date.current}).first
    if !check_absent.blank?
      render :status => 200, :json => {:absent => check_absent}
    else
      render :status => 401, :json => {:message => "Absent Not Found"}
    end
  end

  private
  def get_absent
    @check_absent = current_user_api.absents.where({categories: 1, date: Date.current}).first
  end

end
