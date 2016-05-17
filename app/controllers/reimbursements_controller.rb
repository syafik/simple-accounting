
class ReimbursementsController < ApplicationController # :nodoc:
  load_and_authorize_resource
  # GET /reimbursements
  # GET /reimbursements.json
  def index
    @current_time = Time.zone.now.to_date
    @year = params[:year] || @current_time.year
    @month = params[:month] || @current_time.month
    day = params[:day] || @current_time.day
    @date = DateTime.new(@year.to_i, @month.to_i, 1)
    @next = @date + 1.month
    @prev = @date - 1.month
    @start_date = @date.beginning_of_month
    @end_date = @date.end_of_month
    @reimbursements = Reimbursement.where(:created_at => @start_date..@end_date).order("created_at DESC").paginate(per_page: 100, page: params[:page])
    @total_approve = @reimbursements.map!(&:total_approve).grep(Integer).sum
    @total_claim = @reimbursements.sum("total_claim")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reimbursements }
    end
  end

  # GET /reimbursements/1
  # GET /reimbursements/1.json
  def show
    @reimbursement = Reimbursement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reimbursement }
    end
  end

  # GET /reimbursements/new
  # GET /reimbursements/new.json
  def new
    @year_insurances = YearInsurance.active.joins(:family)
    @reimbursement = Reimbursement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reimbursement }
    end
  end

  # GET /reimbursements/1/edit
  def edit
    @year_insurances = YearInsurance.active.joins(:family)
    @reimbursement = Reimbursement.find(params[:id])
  end

  # POST /reimbursements
  # POST /reimbursements.json
  def create
    @reimbursement = Reimbursement.new(params[:reimbursement])
    @year_insurances = YearInsurance.active.joins(:family)
    respond_to do |format|
      if @reimbursement.save
        format.html { redirect_to reimbursements_path, notice: 'Reimbursement was successfully created.' }
        format.json { render json: @reimbursement, status: :created, location: @reimbursement }
      else
        format.html { render action: "new" }
        format.json { render json: @reimbursement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reimbursements/1
  # PUT /reimbursements/1.json
  def update
    @reimbursement = Reimbursement.find(params[:id])
    @year_insurances = YearInsurance.active.joins(:family)
    respond_to do |format|
      if @reimbursement.update_attributes(params[:reimbursement])
        format.html { redirect_to reimbursements_path, notice: 'Reimbursement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reimbursement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reimbursements/1
  # DELETE /reimbursements/1.json
  def destroy
    @reimbursement = Reimbursement.find(params[:id])
    @reimbursement.destroy

    respond_to do |format|
      format.html { redirect_to reimbursements_url }
      format.json { head :no_content }
    end
  end

  def users
    @families = Family.active.where("parent_id IS NULL")
  end

  def list_claim
    @family = Family.where(familyable_id: params[:reimbursement_id], familyable_type: "User").first
    family_ids = @family.children.map(&:id)
    family_ids << @family.id
    @year_insurances = YearInsurance.where(family_id: family_ids ).by_year(params[:year])
  end

  def reject
    reimbursement = Reimbursement.find(params[:id])
    reimbursement.update_attributes(status: Reimbursement.statuses[2])
    NotificationMailer.reject_reimbursement(reimbursement).deliver rescue nil
    redirect_to reimbursements_path
  end

  def approve
    @reimbursement = Reimbursement.find(params[:id])
    if @reimbursement.status == "approve"
      return redirect_to reimbursements_path, notice: "Data Tidak ditemukan"
    end
  end

  def process_approve
    @reimbursement = Reimbursement.find(params[:id])
    params[:reimbursement][:status] = "approve"
    max_flafond = 0
    if @reimbursement.reimbursement_type == "RJ"
      max_flafond  = @reimbursement.year_insurance.saldo_rj
    elsif @reimbursement.reimbursement_type == "RI"
      max_flafond = @reimbursement.total_day * @reimbursement.year_insurance.grade.ri
    elsif @reimbursement.reimbursement_type == "OPERASI"
      max_flafond =  @reimbursement.year_insurance.grade.operasi
    elsif @reimbursement.reimbursement_type == "RB NORMAL"
      max_flafond =  @reimbursement.year_insurance.grade.rb_normal
    elsif @reimbursement.reimbursement_type == "RB CAESAR"
      max_flafond =  @reimbursement.year_insurance.grade.rb_caesar
    end
    sisa = max_flafond - params[:reimbursement][:total_approve].to_i
    if sisa >= 0

      @reimbursement.update_attributes(params[:reimbursement])
      if @reimbursement.reimbursement_type == "RJ"
        year_insurance = @reimbursement.year_insurance
        year_insurance.update_attributes(saldo_rj: sisa)
      end
      NotificationMailer.approve_reimbursement(@reimbursement).deliver rescue nil
      redirect_to reimbursements_path, notice: 'Reimbursement was successfully updated.'
    else
      render "approve", notice: 'Total Klaim melebihi plafond '
    end
  end
end
