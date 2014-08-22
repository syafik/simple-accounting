
class AllowanceCategoriesController < ApplicationController
  # GET /allowance_categories
  # GET /allowance_categories.json
  def index

    @allowance_categories = AllowanceCategory.all
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @allowance_categories }
    end
  end

  # GET /allowance_categories/1
  # GET /allowance_categories/1.json
  def show
    @allowance_category = AllowanceCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @allowance_category }
    end
  end

  # GET /allowance_categories/new
  # GET /allowance_categories/new.json
  def new
    @allowance_category = AllowanceCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @allowance_category }
    end
  end

  # GET /allowance_categories/1/edit
  def edit
    @allowance_category = AllowanceCategory.find(params[:id])
  end

  # POST /allowance_categories
  # POST /allowance_categories.json
  def create
    @allowance_category = AllowanceCategory.new(params[:allowance_category])

    respond_to do |format|
      if @allowance_category.save
        format.html { redirect_to @allowance_category, notice: 'Allowance category was successfully created.' }
        format.json { render json: @allowance_category, status: :created, location: @allowance_category }
      else
        format.html { render action: "new" }
        format.json { render json: @allowance_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /allowance_categories/1
  # PUT /allowance_categories/1.json
  def update
    @allowance_category = AllowanceCategory.find(params[:id])

    respond_to do |format|
      if @allowance_category.update_attributes(params[:allowance_category])
        format.html { redirect_to @allowance_category, notice: 'Allowance category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @allowance_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /allowance_categories/1
  # DELETE /allowance_categories/1.json
  def destroy
    @allowance_category = AllowanceCategory.find(params[:id])
    @allowance_category.destroy

    respond_to do |format|
      format.html { redirect_to allowance_categories_url }
      format.json { head :no_content }
    end
  end

  def findSubCategories
    @allowance_category = AllowanceCategory.find(params[:id])
    @allowance_sub_category = @allowance_category.allowance_sub_category
    respond_to do |format|
      format.js 

    end
  end
end
