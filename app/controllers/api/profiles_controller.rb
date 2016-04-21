class Api::ProfilesController < Api::ApiController
  respond_to :json

  ##
  # ::Profile
  # ===Profile
  # method:
  #   GET
  # url:
  #   /api/profiles
  # header:
  #   content-type: application/json
  #   authorization:Token token= authtentication_token
  # response:
  # * success
  #   {
  #     "avatar":"http://apps.staging.pushjaw.com/assets/avatar3.png",
  #     "name":"admin ",
  #     "email":"admin@pushjaw.com",
  #     "posisi":"admin",
  #     "notlp":"1234432",
  #     "bank":"test",
  #     "norek":"1234566",
  #     "cabang":"admin",
  #     "namaakun":"bank"
  #    }
  def index
    @user = current_user_api
  end

end
