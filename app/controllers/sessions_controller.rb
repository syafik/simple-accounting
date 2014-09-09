class SessionsController < Devise::SessionsController
	
	
	def create
		self.resource = warden.authenticate!(auth_options)
		set_flash_message(:notice, :signed_in) if is_navigational_format?
		sign_in(resource_name, resource);
		check_absent = current_user.absents.where({categories: 1, date: Date.today})
		if check_absent.empty?
			current_user.absents.create({categories: 1, date: Date.today, time_in: Time.now.strftime("%I:%M:%S") })
		end
		respond_with resource, :location => after_sign_in_path_for(resource)
		
	end

	def destroy
		redirect_path = after_sign_out_path_for(resource_name)

		check_absent = current_user.absents.where({categories: 1, date: Date.today})
		p check_absent.select("id")
		absents = Absent.find(check_absent.select("id"))


		absents.update_attributes(time_out: Time.now.strftime("%I:%M:%S"))


		signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
		set_flash_message :notice, :signed_out if signed_out && is_navigational_format?
		# We actually need to hardcode this as Rails default responder doesn't
		# support returning empty response on GET request
		respond_to do |format|
			format.all { head :no_content }
			format.any(*navigational_formats) { redirect_to redirect_path }
		end
	end
end


