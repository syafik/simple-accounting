
class FamiliesController < ApplicationController # :nodoc:
  load_and_authorize_resource
  before_filter :set_parent_family
  # GET /families
  # GET /families.json
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @families }
    end
  end

  # GET /families/1
  # GET /families/1.json
  def show
    @family = Family.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @family }
    end
  end

  # GET /families/new
  # GET /families/new.json
  def new

    @family = Family.new()

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @family }
    end
  end

  # GET /families/1/edit
  def edit
    @family = Family.find(params[:id])
  end

  # POST /families
  # POST /families.json
  def create
    @family = Family.new(params[:family])

    respond_to do |format|
      if @family.save
        format.html { redirect_to @family, notice: 'Family was successfully created.' }
        format.json { render json: @family, status: :created, location: @family }
      else
        format.html { render action: "new" }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /families/1
  # PUT /families/1.json
  def update
    @family = Family.find(params[:id])

    respond_to do |format|
      if @family.update_attributes(params[:family])
        format.html { redirect_to @family, notice: 'Family was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /families/1
  # DELETE /families/1.json
  def destroy
    @family = Family.find(params[:id])
    @family.destroy

    respond_to do |format|
      format.html { redirect_to families_url }
      format.json { head :no_content }
    end
  end

  def add_employee
    @users = User.joins("left join families on users.id = families.familyable_id AND families.familyable_type='User' ").where("families.familyable_id is null AND  families.familyable_type is null")
  end

  def save_employee
    user = User.find(params[:employee_id]) if params[:employee_id].present?
    if user.present? && !user.family
      family = Family.new
      family.familyable = user
      family.name = user.first_name
      family.save
      redirect_to families_path
    else
      redirect_to add_employee_families_path, notice: 'data gagal di simpan.'
    end
  end

  def generate_year
    family = Family.find(params[:id])
    if family.year_insurances.active.empty?
      prepare_generate_year(family)
    end
    redirect_to families_path
  end

  private
  def set_parent_family
    @families = Family.active.where("parent_id IS NULL")
  end

  def prepare_generate_year(family)
    grade = if family.parent_id.nil?
      family.familyable.salary_histories.activate.first.grade
    else
      family.parent.familyable.salary_histories.activate.first.grade
    end
    YearInsurance.create!(year: Date.today.year, family_id: family.id, grade_id: grade.id, saldo_rj: grade.rj)
    family.children.each do |child|
      prepare_generate_year(child)
    end
  end
end
