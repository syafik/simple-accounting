class AllowanceSubCategoriesController < ApplicationController
  load_and_authorize_resource

  before_filter :get_allowance_categories,  :except => [:index, :show, :destroy] 
  def new
  	@allowance_sub_category = AllowanceSubCategory.new
  end

  def create
    @allowance_category = AllowanceCategory.find(params[:allowance_category_id])
    @allowance_sub_category = @allowance_category.allowance_sub_categories.create(params[:allowance_sub_category])
    redirect_to allowance_category_path(@allowance_category)
    # respond_to do |format|
    #   format.js
    # end
  end

  def edit
    @allowance_sub_category = AllowanceSubCategory.find(params[:id])
    #@allowance_category.allowance_sub_category.map { |allowance_category| allowance_category.id  }
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
    @allowance_category = AllowanceCategory.find(params[:allowance_category_id])
    @allowance_sub_category =  @allowance_category.allowance_sub_categories.find(params[:id])
    @allowance_sub_category.destroy
  end

  private
  def get_allowance_categories
    @allowance_categories = AllowanceCategory.all.map { |allowance_category| [allowance_category.name, allowance_category.id] }
  end

end
