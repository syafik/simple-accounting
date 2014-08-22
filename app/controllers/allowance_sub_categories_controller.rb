
class AllowanceSubCategoriesController < ApplicationController
  before_filter :get_allowance_categories,  :except => [:index, :show, :destroy] 
  def new
  	@allowance_sub_category = AllowanceSubCategory.new
  end

  def create
  	@allowance_sub_category = AllowanceSubCategory.new(params[:allowance_sub_category])

  	if @allowance_sub_category.save
			redirect_to @allowance_sub_category
		else
      render 'new'
		end
  end

  def edit
    @allowance_sub_category = AllowanceSubCategory.find(params[:id])
  end

  def update
    @allowance_sub_category = AllowanceSubCategory.find(params[:id])

     if @allowance_sub_category.update_attributes(params[:allowance_sub_category])
      redirect_to @allowance_sub_category
    else
      render 'edit'
    end
  end

  def show
  	@allowance_sub_category = AllowanceSubCategory.find(params[:id])
  	@allowance_category = @allowance_sub_category.allowance_category
  end

  def index
    @allowance_sub_categories = AllowanceSubCategory.order('allowance_category_id asc')
  end

  def destroy
    @allowance_sub_category = AllowanceSubCategory.find(params[:id])
    @allowance_sub_category.destroy
    redirect_to allowance_sub_categories_path
  end

  private
    def get_allowance_categories
      @allowance_categories = AllowanceCategory.all.map { |allowance_category| [allowance_category.name, allowance_category.id] }
    end


end
