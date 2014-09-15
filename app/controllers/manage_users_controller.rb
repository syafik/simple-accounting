
class ManageUsersController < ApplicationController

  def new
 @manage_user = User.new
 @manage_user.salary_histories.build
 @manage_user.overtime_payment_histories.build
  end

  def create
    @manage_user = User.new(params[:user])
    
    @manage_user.password = "12345678"
    respond_to do |format|
      if @manage_user.save(validated: false)

        # @manage_user.salary_histories.create(:payment => params[:salary], :date => Date.today, :activate=>true)
        # UserMailer.send_accsess_new_user(@manage_user).deliver



        format.html { redirect_to manage_user_url(@manage_user) , notice: 'User was successfully created.' }
        format.json { render json: @new_manage_user , status: :created, location: @manage_user  }
      else
        format.html { render action: "new" }
        format.json { render json: @new_manage_user .errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @manage_user = User.find(params[:id])
    

    respond_to do |format|
      if @manage_user.update_attributes(params[:user])
        format.html { redirect_to manage_user_url(@manage_user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @manage_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @manage_user = User.find(params[:id])
  end


  def index
    @manage_users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @manage_users  }
    end
  end

  def show
    @manage_user =User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @manage_user }
    end
  end

  def destroy
    @manage_user = User.find(params[:id])
    @manage_user.destroy

    # respond_to do |format|
    #   format.html { redirect_to format }
    #   manage_users_url.json { head :no_content }
    #   format.json { render json: @manage_users }
    # end


    respond_to do |format|
      format.html { redirect_to manage_users_url }
      format.json { head :no_content }
    end
  end

end
