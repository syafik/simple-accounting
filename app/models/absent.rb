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
end
