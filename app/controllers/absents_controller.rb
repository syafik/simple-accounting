
class AbsentsController < ApplicationController
  # GET /absents
  # GET /absents.json
  def index
    if params[:search]
      @absents =  Absent.where(categories: params[:search])
    else 
      @absents = Absent.order("date desc")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @absents }
      format.js
    end
  end

  # GET /absents/1
  # GET /absents/1.json
  def show
    @absent = Absent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @absent }
    end
  end

  # GET /absents/new
  # GET /absents/new.json
  def new
    @absent = Absent.new
    #@absent_categories = AbsentCategory.all.map { |absent_category| [absent_category.category_name, absent_category.id] }
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @absent }
    end
  end

  # GET /absents/1/edit
  def edit
    @absent = Absent.find(params[:id])
  end

  # POST /absents
  # POST /absents.json
  def create
    @absent = Absent.new(params[:absent])

    respond_to do |format|
      if @absent.save
        format.html { redirect_to @absent, notice: 'Absent was successfully created.' }
        format.json { render json: @absent, status: :created, location: @absent }
      else
        format.html { render action: "new" }
        format.json { render json: @absent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /absents/1
  # PUT /absents/1.json
  def update
    @absent = Absent.find(params[:id])

    respond_to do |format|
      if @absent.update_attributes(params[:absent])
        format.html { redirect_to @absent, notice: 'Absent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @absent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /absents/1
  # DELETE /absents/1.json
  def destroy
    @absent = Absent.find(params[:id])
    @absent.destroy

    respond_to do |format|
      format.html { redirect_to absents_url }
      format.json { head :no_content }
    end
  end
end
