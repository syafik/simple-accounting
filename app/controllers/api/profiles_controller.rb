
class Api::ProfilesController < ApplicationController
  skip_before_filter :authenticate_user!, :verify_authenticity_token
  before_filter :authenticate_api
  respond_to :json

  ## Profile
  def show
    @user =User.find(params[:id])
    render :status => 200, :json =>{:name => @user.full_name,
     :posisi => @user.position,
     :no_tlp => @user.telephone,
     :bank => @user.bank_name,
     :no_rekening => @user.account_number,
     :cabang => @user.account_branch_name,
     :nama_akun => @user.account_name
   }
  end
end
