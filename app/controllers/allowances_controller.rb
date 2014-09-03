
class AllowancesController < ApplicationController
  before_filter :get_allowance_sub_categories_user,  :except => [:show, :destroy, :find_sub_categories] 

  def new
  	@allowance = Allowance.new
  end

  def create
  	@allowance = Allowance.new(params[:allowance])

  	if @allowance.save
			redirect_to @allowance
		else
			render 'new'
		end
  end

  def update
     @allowance = Allowance.find(params[:id])

     if @allowance.update_attributes(params[:allowance])
      redirect_to @allowance
    else
      render 'edit'
    end
  end

  def edit
  	@allowance = Allowance.find(params[:id]) 
    
  end

  def index
     #@allowance = Allowance.search(params[:search])

  	@allowances = Allowance.search(params[:search],params[:search_by])
    p "-------------"
    p @allowances
    #@allowance_categories = AllowanceCategory.all.map { |allowance_category| [allowance_category.name, allowance_category.id] }
    # if params[:search] == nil
    #   @allowances = Allowance.all
    # else
    #   @allowance_sub_category = AllowanceSubCategory.find_by_name(params[:search])
    #   @allowance = @allowance_sub_category.allowances

    #   p "==========="

    #   p @allowance
    # end
    
  end

  def show
  	@allowance = Allowance.find(params[:id])
  	@allowance_sub_category = @allowance.allowance_sub_category
  	@user = @allowance.user
  end

  def destroy
    @allowance = Allowance.find(params[:id])
    @allowance.destroy
    redirect_to allowances_path
  end

  def find_sub_categories
    @allowance_category = AllowanceCategory.find(params[:id])
    @allowance_sub_category = @allowance_category.allowance_sub_categories.map { |allowance_sub_category| [allowance_sub_category.name, allowance_sub_category.id] }
    respond_to do |format|
      format.js 
    end
  end

  def find_available_category
    p params
    if params[:id].to_i == 2
      @allowance_sub_category = AllowanceSubCategory.all
    elsif params[:id].to_i == 1
      
    else 
      p "eloooo"
    end


     # @allowance_category = AllowanceCategory.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  private
  	def allowance_params
  		params.require(:allowace).permit(:user_id, :allowance_category_id, :max_cay, :value)
  	end

    def get_allowance_sub_categories_user
      @allowance_sub_categories = AllowanceSubCategory.all.map { |allowance_sub_category| [allowance_sub_category.name, allowance_sub_category.id] }
      @allowance_categories = AllowanceCategory.all.map { |allowance_category| [allowance_category.name, allowance_category.id] }
      @users = User.all.map { |user| [user.email, user.id] }
    end
end
