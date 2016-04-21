class Api::ApiController < ApplicationController # :nodoc:
  skip_before_filter :authenticate_user!
  before_filter :authenticate_api
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
    render json:{:message => 'Unauthorized' }, status: 401
  end
end
