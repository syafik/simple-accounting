class OvertimePaymentHistoriesController < ApplicationController
  load_and_authorize_resource

	before_filter :get_user, :only => [:new, :create, :edit, :update]

	def index
		@oph = OvertimePaymentHistory.order("applicable_date asc")
	end

	def show
		@oph = OvertimePaymentHistory.find(params[:id])


		respond_to do |format|
		      format.html  #show.html.erb
		      format.json { render json: @oph }
		    end
		  end

		  def new
		  	@oph = OvertimePaymentHistory.new

		  	respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @oph }
	    end
	  end

	  def create
	  	params[:overtime_payment_history][:applicable_date] = DateTime.strftime(params[:overtime_payment_history][:applicable_date], "%m/%d/%Y").to_date
	  	@oph = OvertimePaymentHistory.new(params[:overtime_payment_history])

	  	respond_to do |format|
	  		if @oph.save
	  			format.html { redirect_to @oph, notice: 'Salary history was successfully created.' }
	  			format.json { render json: @oph, status: :created, location: @oph }
	  		else
	  			format.html { render action: "new" }
	  			format.json { render json: @oph.errors, status: :unprocessable_entity }
	  		end
	  	end
	  end

	  def edit
	  	@oph = OvertimePaymentHistory.find(params[:id])
	  end

	  def update
	  	@oph = OvertimePaymentHistory.find(params[:id])

	  	respond_to do |format|
	  		if @oph.update_attributes(params[:overtime_payment_history])
	  			format.html { redirect_to @oph, notice: 'Salary history was successfully updated.' }
	  			format.json { head :no_content }
	  		else
	  			format.html { render action: "edit" }
	  			format.json { render json: @oph.errors, status: :unprocessable_entity }
	  		end
	  	end
	  end

	  def set_activation
	  	@oph = OvertimePaymentHistory.find(params[:id])
	  	@oph.update_attributes(:activate => true)

	  	if OvertimePaymentHistory.update_all("activate = false", "id <> #{ params[:id] } AND user_id = #{@oph.user_id}" )
	  		redirect_to overtime_payment_histories_path
	  	end
	  end

	  private
	  def get_user
	  	@users = User.all.map {|user| [user.email, user.id]}
	  end
	end
