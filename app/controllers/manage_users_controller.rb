class ManageUsersController < ApplicationController
  load_and_authorize_resource :class => "User"

  before_filter :get_roles,  :only => [:new, :create, :update, :edit] 

  def new
   @user = User.new
   @user.salary_histories.build
   @user.overtime_payment_histories.build
 end

 def create

  @user = User.new(params[:user])
  @user.password = "12345678"
  respond_to do |format|
    if @user.save(validated: false)
        format.html { redirect_to manage_user_url(@user) , notice: 'User was successfully created.' }
        format.json { render json: @new_manage_user , status: :created, location: @user  }
      else
        format.html { render action: "new" }
        format.json { render json: @new_manage_user .errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to manage_user_url(@user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end


  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users  }
    end
  end

  def show
    @user =User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to manage_users_url }
      format.json { head :no_content }
    end
  end

  def get_roles
    @roles = Role.all.map { |role| [role.name, role.id]}
  end

  private
  def check_date
    if  params[:user][:birth_date] .is_a?(String)
      params[:user][:birth_date]  = DateTime.strptime(params[:user][:birth_date] , "%m/%d/%Y").to_date

    end
  end

end
