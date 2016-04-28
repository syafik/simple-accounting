
class Api::AbsentsController < Api::ApiController
  skip_before_filter :verify_authenticity_token
  before_filter :get_absent, :only => [:create]
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
    if $redis.get("barcodes").to_i == params[:barcodes].to_i
        if @check_absent
                render :status=>200, :json=>@check_absent
        else
          absent = current_user_api.absents.build(:date => time_in.to_date, :categories => 1, :time_in => Time.zone.now.strftime("%H:%M:%S"))
        if absent.save!
          get_summary
          render :status=>200, :json=> {:absent => {date: absent.date.strftime("%d %B %Y"), time_in: absent.time_in.strftime("%H:%M"), jumlah: @absent.jumlah, bulan: Time.zone.now.strftime("%B %Y")}}
        else
          render :status=>404, :json=>{:message=>"Parameter Terjadi Kesalahan, Coba lagi"}
        end
        end
    else
      render :status=>404, :json => {:message => "Barcode Terjadi Kesalahan, Coba lagi"}
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
    if check_absent.blank?
      render :status => 404, :json => {:message => "Absent Not Found"}
    else
      get_summary
      render :status => 200, :json => {:absent => {date: check_absent.date.strftime("%d %B %Y"), time_in: check_absent.time_in.strftime("%H:%M"), jumlah: @absent.jumlah, bulan: Time.zone.now.strftime("%B %Y")}}
    end
  end

  private
  def get_absent
    @check_absent = current_user_api.absents.where({categories: 1, date: Date.current}).first
  end

  def get_summary
    date = Time.zone.now
    year = date.year
    month = date.month
    @absent = User.joins("left join absents on absents.user_id = users.id AND MONTH(absents.date) = #{month} AND YEAR(absents.date) =  #{year}").
    select("users.first_name, users.last_name, count(absents.user_id) as jumlah ").where(id: current_user_api.id).group("absents.user_id").first rescue nil

  end

end
