class AvatarController < ApplicationController
  def destroy
  	user = User.find(params[:id])
    user.avatar = nil
    user.save

    respond_to do |format|
      format.html { redirect_to manage_users_url, notice: 'Photo was successfully destroyed' }
      format.json { head :no_content }
    end
  end
end