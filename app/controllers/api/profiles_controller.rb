
class Api::ProfilesController < ApplicationController
  skip_before_filter :authenticate_user!, :verify_authenticity_token
  before_filter :authenticate_api
  respond_to :json

  ## Profile
  def index
    @user = current_user_api
  end

end
