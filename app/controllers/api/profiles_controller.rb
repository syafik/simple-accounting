class Api::ProfilesController < Api::ApiController
  skip_before_filter :authenticate_user!, :verify_authenticity_token
  before_filter :authenticate_api
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
  #     "avatar":"http://localhost:3000/assets/avatar3.png",
  #     "name":"Admin pushjaw",
  #     "email":"admin@pushjaw.com",
  #     "posisi":"Admin",
  #     "notlp":"0987654321",
  #     "bank":"BCA",
  #     "norek":"12345",
  #     "cabang":"Cianjur",
  #     "namaakun":"nama akun"
  #    }
  def index
    @user = current_user_api
  end

end
