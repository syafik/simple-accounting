class BarcodesController < ApplicationController
  layout 'clean'
  skip_before_filter :authenticate_user!
  def index
    @qr = RQRCode::QRCode.new( Time.zone.now.to_i.to_s, :size => 4, :level => :h )
  end
end
