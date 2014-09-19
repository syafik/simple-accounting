
class AbsentPermissionsController < ApplicationController
  before_filter :get_history,  :only => [:new, :create] 
  # GET /absent_permissions
  # GET /absent_permissions.json
  def index
    if current_user.role_id == 2
        @absent_permissions = AbsentPermission.admin_search(params[:search],current_user)#.paginate(:page => params[:page], :per_page => 1)
        

        
      end
      # @absent_permissions = AbsentPermission.all

      respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @absent_permissions }
    end
  end

  # GET /absent_permissions/1
  # GET /absent_permissions/1.json
  def show
    @absent_permission = AbsentPermission.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @absent_permission }
    end
  end

  # GET /absent_permissions/new
  # GET /absent_permissions/new.json
  def new
    @absent_permission = AbsentPermission.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @absent_permission }
    end
  end

  # GET /absent_permissions/1/edit
  def edit
    @absent_permission = AbsentPermission.find(params[:id])
  end

  # POST /absent_permissions
  # POST /absent_permissions.json
  def create
    params[:absent_permission][:status] = 0

    hbt = AbsentPermission.have_been_taken(current_user)

    start_date = DateTime.parse(params[:absent_permission][:start_date])
    end_date = nil

    if params[:absent_permission][:category] == "1"
      params[:absent_permission][:long] = 1
      params[:absent_permission][:end_date] =  params[:absent_permission][:start_date]
    else
      end_date = DateTime.parse(params[:absent_permission][:end_date])
      params[:absent_permission][:long] = (end_date -start_date).to_i
    end
    @absent_permission = AbsentPermission.new(params[:absent_permission])
      

      respond_to do |format|
        if hbt  < current_user.max_furlough && params[:absent_permission][:long]  < current_user.max_furlough && @absent_permission.save
          format.html { redirect_to @absent_permission, notice: 'Absent permission was successfully created.' }
          format.json { render json: @absent_permission, status: :created, location: @absent_permission }
        else
          format.html { render action: "new" }
          format.json { render json: @absent_permission.errors, status: :unprocessable_entity }
        end
      end

   end

  # PUT /absent_permissions/1
  # PUT /absent_permissions/1.json
  def update
    if current_user.role_id == 2
      params[:absent_permission][:status] = 2
    else
      params[:absent_permission][:status] = 0
    end
    
    @absent_permission = AbsentPermission.find(params[:id])
    
    respond_to do |format|
      if @absent_permission.update_attributes(params[:absent_permission])
        format.html { redirect_to @absent_permission, notice: 'Absent permission was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @absent_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /absent_permissions/1
  # DELETE /absent_permissions/1.json
  def destroy
    @absent_permission = AbsentPermission.find(params[:id])
    @absent_permission.destroy

    respond_to do |format|
      format.html { redirect_to absent_permissions_url }
      format.json { head :no_content }
    end
  end

  def set_approval
    p "masuk approval"
    p params
    @absent_permission = AbsentPermission.find(params[:id])
    #cek status
    decision = params[:decision]
    p decision

    if decision == "rejected"
      @absent_permission.update_attributes(:status=>2, :description=> params[:description], :approval_date => Date.today)
    elsif decision == "approved"
      if params[:long]
        end_date = @absent_permission.start_date +  params[:long].days rescue nil
      else
        end_date = @absent_permission.start_date + @absent_permission.long.days rescue nil
      end
      p "======"
      p "masuk"
      @absent_permission.update_attributes(:status=>1, :description=> params[:description], :approval_date => Date.today, :end_date => end_date )
    end


    
  end

  def set_taken
    p "======="
    p params
    @absent_permission = AbsentPermission.find(params[:id])
    p "======="
    p @absent_permission
    @absent_permission.update_attributes(:status=>3)
    @absent_permission.save_to_absent
  end

  def set_decline
    @absent_permission = AbsentPermission.find(params[:id])
    @absent_permission.update_attributes(:status=>4)
  end

  private

  

  def get_history
    @get_absent_permissions = AbsentPermission.user_search(params[:search],current_user)
    p @get_absent_permissions

  end
end
