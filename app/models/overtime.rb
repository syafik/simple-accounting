class Overtime < ActiveRecord::Base
	belongs_to :user 

	attr_accessible :date, :description, :long_overtime, :user_id, :start_time, :end_time, :payment
	validates  :date, :start_time, :end_time,   presence: true

	def self.long_overtime(start_time, end_time)
		difh = end_time.hour - start_time.hour

		if (end_time.min < start_time.min)
			to = end_time.min + 60
		else
			to = end_time.min
		end
		difm = (to - start_time.min).to_f * 0.6
		tot = "#{difh}.#{difm}".to_f 
		
		return tot
	end

	def self.payment_overtime(start_time, end_time, user)
		price_day = user.salary_histories.activate.first.day_payment_overtime
		price_night = user.salary_histories.activate.first.night_payment_overtime
		day_payment = 0
		night_payment = 0
		start_time_day = Time.parse("00:00")
		start_time_night = Time.parse("00:00")
		end_time_day = Time.parse("00:00")
		end_time_night = Time.parse("00:00")

		if start_time.hour < 19 && end_time.hour < 19
			start_time_day = start_time
			end_time_day = end_time
		elsif start_time.hour < 19 && end_time.hour > 19
			start_time_day = start_time
			end_time_day = Time.parse("19:00")
			start_time_night = end_time_day
			end_time_night = end_time
		elsif start_time.hour > 19 && end_time.hour < 19
			start_time_day = Time.parse("02:00")
			end_time_day = end_time
			start_time_night = start_time
			end_time_night = Time.parse("02:00")
		end



		day_payment = long_overtime(start_time_day, end_time_day) * price_day
		night_payment = long_overtime(start_time_night, end_time_night) * price_night

		total_payment = day_payment + night_payment
		return total_payment
		
	end

	def self.total_long_overtime(user, new_long_overtime)
		overtime_history = Overtime.where(:user_id =>  user.id).sum(:long_overtime)
		total_long_overtime = overtime_history.to_i + new_long_overtime

		return total_long_overtime
	end
end
