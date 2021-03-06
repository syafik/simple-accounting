class Absent < ActiveRecord::Base # :nodoc:
  belongs_to :user

  after_create :add_point, :set_barcode

  has_one :point_history, :as => :point_historyable

  attr_accessible :categories, :date, :description, :user_id, :time_in, :time_out, :total_work_time
  validates :date, presence: true
  validates :categories, presence: true

  validates :date, uniqueness: { scope: :user_id, message: "Nama Dengan Tanggal Tersebut Telah Terekap sebelumnya" }

  scope :this_year, where("YEAR(date) = #{Date.today.year}")
  scope :this_month, where("MONTH(date) = #{Date.today.month}")

   scope :total_attendance_by_date, (lambda do |first_date, end_date|
    where("categories = 1 AND date >= ? and date <= ?", first_date, end_date)
  end)
  scope :total_absence_by_date, (lambda do |first_date, end_date|
    where("categories <> 1 AND date >= ? and date <= ?", first_date, end_date)
  end)

  def self.get_total_work_time(time_in, time_out)
    difh = time_out.hour - time_in.hour
    if (time_out.min < time_in.min)
      to = time_out.min + 60
    else
      to = time_out.min
    end
    difm = (to - time_in.min).to_f * 0.6
    tot = "#{difh}.#{difm}".to_f
    return tot
  end

  def create_history(point_id,point)
    self.build_point_history(:user_id => self.user_id, :point_id => point_id, :points => point).save
  end

  def add_point
    begin
    pp = Point.where(:name.downcase => 'absent').first
    point = pp.point
    user = User.find(self.user_id)
    if self.categories == 1
      if  self.time_in.strftime("%H:%M:%S") <= "09:30:00"
          user.point += point
          user.save
          create_history(pp.id,point)
      elsif self.time_in.strftime("%H:%M:%S") <= "10:00:00"
          user.point += point/2
          user.save
          create_history(pp.id , point/2)
      end
    end
  rescue
  end
  end

  def set_barcode
    begin
    $redis.set("barcodes", Random.rand(999999))
    rescue
end
 end

end
