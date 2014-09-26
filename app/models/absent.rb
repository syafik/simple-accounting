class Absent < ActiveRecord::Base
	belongs_to :user
	attr_accessible :categories, :date, :description, :user_id, :time_in, :time_out, :total_work_time
	validates :date, presence: true
	validates :categories, presence: true
  	# validates :description, presence: true
  	# validates :user_id, presence:true

  	validates :date, uniqueness: { scope: :user_id,
      message: "Nama Dengan Tanggal Tersebut Telah Terekap sebelumnya" }

  # before_save :convert_date_string_to_timestamp

  # def convert_date_string_to_timestamp
  # end

  def self.get_total_work_time(time_in, time_out)
    difh = time_out.hour - time_in.hour

    if (time_out.min < time_in.min)
      to = time_out.min + 60
    else
      to = time_out.min
    end
    difm = to - time_in.min
    p "==out=="
    p time_out.min
    p "==in=="
    p time_in.min
    p "==hour=="
    p difh
    p "==min=="
    p difm
    tot = "#{difh}.#{difm}".to_f
    p "==tot=="
    p tot
    return tot
  end
end
