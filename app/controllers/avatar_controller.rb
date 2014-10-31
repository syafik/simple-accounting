class AvatarController < ApplicationController
  def destroy
  	user = User.find(params[:id])
    user.avatar = nil
    user.save

    respond_to do |format|
      format.html { redirect_to manage_user_path(params[:id]), notice: 'Photo was successfully destroyed' }
      format.json { head :no_content }
    end
  end
end