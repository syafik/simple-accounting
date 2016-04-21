class ApplicationController < ActionController::Base # :nodoc:
  protect_from_forgery
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do | exception |
    p "x " * 66
    p exception
    redirect_to root_url, alert: exception.message
  end

end
