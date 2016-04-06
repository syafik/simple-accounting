class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do | exception |
    p "x " * 66
    p exception
    redirect_to root_url, alert: exception.message
  end

  protected

   def current_user_api # :nodoc:
    @user_api
  end

  def authenticate_api
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    @user_api =  authenticate_with_http_token do |token, options|
      User.where(authentication_token: token).first
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: 'Bad credentials', status: 401
  end

end
