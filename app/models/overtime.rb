class Overtime < ActiveRecord::Base
	belongs_to :user 

	attr_accessible :date, :description, :long_overtime, :user_id, :start_time, :end_time, :payment, :status, :day_payment, :night_payment
	validates  :date, :start_time, :end_time,   presence: true

	def self.long_overtime(start_time, end_time)
		if end_time.hour < start_time.hour
			te = end_time.hour + 24
		else
			te = end_time.hour
		end


		difh = te - start_time.hour

		if (end_time.min < start_time.min)
			to = end_time.min + 60
		else
			to = end_time.min
		end


		difm = (to - start_time.min).to_f * 0.6
		tot = "#{difh}.#{difm}".to_f 
		
		return tot
	end

	def self.day_payment_overtime(start_time, end_time, user)
		price_day = user.salary_histories.activate.first.day_payment_overtime rescue 0
		ls = Time.parse(Setting[:startlimitdaytime]) #limit start
		lf = Time.parse(Setting[:startlimitnighttime]) #limit finish
		start = Time.parse(start_time.strftime("%H:%M "))
		finish = Time.parse(end_time.strftime("%H:%M "))

		if Time.parse(start_time.strftime("%H:%M ")) < ls && Time.parse(end_time.strftime("%H:%M ")) > lf
			p "masuuuuuuuuuuuuuuuuuuk"
			start = Time.parse("00:00")
			finish = Time.parse("00:00")
		elsif Time.parse(start_time.strftime("%H:%M ")) < ls || Time.parse(start_time.strftime("%H:%M ")) >= lf
			start = ls
		elsif Time.parse(end_time.strftime("%H:%M ")) > lf
			finish = lf
		end



		long = long_overtime(start, finish)

		

		day_payment = long * price_day
		
		return day_payment
	end


	def self.night_payment_overtime(start_time, end_time, user)
		price_night = user.salary_histories.activate.first.night_payment_overtime rescue 0
		ls = Time.parse(Setting[:startlimitnighttime]) #limit start
		lf = Time.parse(Setting[:startlimitdaytime]) #limit finish
		start = Time.parse(start_time.strftime("%H:%M "))
		finish = Time.parse(end_time.strftime("%H:%M "))

		if Time.parse(start_time.strftime("%H:%M ")) < ls && Time.parse(end_time.strftime("%H:%M ")) > lf
			start = Time.parse("00:00")
			finish = Time.parse("00:00")
		elsif Time.parse(start_time.strftime("%H:%M ")) < ls
			start = ls
		elsif Time.parse(end_time.strftime("%H:%M ")) > lf
			finish = lf
		end

		long = long_overtime(start, finish)
		

		night_payment = long * price_night
		return night_payment
	end

	

	def self.total_long_overtime(user, new_long_overtime)
		
		overtime_history = Overtime.where("user_id = ? AND status = ? AND date = ?", user.id, true, Time.now).sum(:long_overtime)
		total_long_overtime = overtime_history.to_i + new_long_overtime

		return total_long_overtime
	end
end
