class Overtime < ActiveRecord::Base # :nodoc:
  belongs_to :user

  attr_accessible :date, :description, :long_overtime, :user_id, :start_time, :end_time, :payment, :status, :day_payment, :night_payment
  validates :date, :start_time, :end_time, presence: true

  after_validation :calculate_time

  scope :total_overtime_by_date, (lambda do |first_date, end_date|
    where("status = 1 AND date >= ? and date <= ?", first_date, end_date)
  end)

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

  def self.total_long_overtime(user, new_long_overtime)
    overtime_history = Overtime.where("user_id = ? AND status = ? AND date = ?", user.id, 1, Time.now).sum(:long_overtime)
    total_long_overtime = overtime_history.to_i + new_long_overtime

    return total_long_overtime
  end

  def calculate_time
    s_time = self.start_time
    e_time = self.end_time
    c_date = self.date

    start_time = Time.parse("#{c_date.strftime("%Y/%m/%d")} #{s_time.strftime("%H:%M")}")
    if (e_time.strftime("%H:%M") == "00:00")
      c_date = c_date + 1.days
    end
    end_time = Time.parse("#{c_date.strftime("%Y/%m/%d")} #{e_time.strftime("%H:%M")}")

    siang = Time.parse("#{c_date.strftime("%Y/%m/%d")} #{Setting[:startlimitdaytime]}")
    malam = Time.parse("#{c_date.strftime("%Y/%m/%d")} #{Setting[:startlimitnighttime]}") #limit finish

    p s_siang = siang
    p e_siang = malam
    p s_malam = malam
    p e_malam = Time.parse("#{(c_date + 1.days).strftime("%Y/%m/%d")} 00:00")
    p s_malam_1 = Time.parse("#{c_date.strftime("%Y/%m/%d")} 00:00")
    p e_malam_1 = s_siang

    total_jam = ((end_time - start_time) / 1.hour).round
    if end_time <= e_siang && start_time >= s_siang

      jam_siang = ((end_time - start_time) / 1.hour).round
      jam_malam = 0
    elsif (end_time <= e_malam && start_time >= s_malam) || (start_time >= s_malam_1 && end_time <= e_malam_1)

      jam_siang = 0
      jam_malam = ((end_time - start_time) / 1.hour).round

    elsif  start_time <= e_malam && end_time < e_siang
      #"awal malam akhir siang
      jam_malam = ((siang - start_time) / 1.hour).round
      jam_siang = total_jam - jam_malam
    elsif start_time < e_siang && end_time < e_malam
      #awal siang akhisr malam

      jam_siang = ((malam - start_time) / 1.hour).round
      jam_malam = total_jam - jam_siang
    end

    self.long_day = jam_siang
    self.long_night = jam_malam
    self.long_overtime = total_jam

    if self.long_overtime > Setting[:maxovertimeperday].to_f
      self.errors.add(:long_overtime, "Jam Lembur kelebihan.")
    end
    self.day_payment = (self.user.salary_histories.activate.first.day_payment_overtime * self.long_day) rescue 0
    self.night_payment = (self.user.salary_histories.activate.first.night_payment_overtime * self.long_night) rescue 0
    self.payment = self.day_payment + self.night_payment
    self.status = 0
  end

  def approved?
    status == 1
  end

  def waiting?
    status == 0
  end
end
