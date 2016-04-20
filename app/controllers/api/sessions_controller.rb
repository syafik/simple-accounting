
class Api::SessionsController < Devise::SessionsController

  skip_before_filter :verify_authenticity_token
  respond_to :json

  ##
  # ::Login
  # === Login
  # method:
  #   POST
  # url:
  #   /api/sessions
  # header :
  #   content-type : application/json
  # parameter body:
  #   {
  #      "email" : "admin@pushjaw.com",
  #      "password" : "12345678"
  #   }
  # response:
  # * success
  #       {
  #          "token":"qpGn1CNyuR5vt9sz9RxE"
  #       }
  # * Failed:
  #     { "message": "Invalid email or password." }
  def create
    email = params[:email]
      password = params[:password]

    if email.nil? or password.nil?
       render :status=>400,
              :json=>{:message=>"The request must contain the user email and password."}
       return
    end

    @user=User.find_by_email(email.downcase)

    if @user.nil?
      logger.info("User #{email} failed signin, user cannot be found.")
      render :status=>401, :json=>{:message=>"Invalid email or passoword."}
      return
    end

    if @user.valid_password?(password)
      @user.reset_authentication_token!
      @user.ensure_authentication_token!
      render :status=>200, :json=>{:token=>@user.authentication_token}
    else
      logger.info("User #{email} failed signin, password \"#{password}\" is invalid")
      render :status=>401, :json=>{:message=>"Invalid email or password."}
    end
  end

##
# ::Logout
# ===Logout
# method:
#   DELETE
# url:
#   /api/sessions/:authentication_token
# header:
#   content-type: application/json
#   authorization:Token token=qpGn1CNyuR5vt9sz9RxE
# response:
# * success
#   {
#     "token":"qpGn1CNyuR5vt9sz9RxE"
#   }
# * Failed
#   {
#     "message":"Invalid token."
#   }
  def destroy
  @user=User.find_by_authentication_token(params[:id])
    if @user.nil?
      logger.info("token not found.")
      render :status=>404, :json=>{:message=>"Invalid token."}
    else
      @user.reset_authentication_token!
      render :status=>200, :json=>{:token=>params[:id]}
    end
  end
end
