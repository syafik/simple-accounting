class SessionsController < Devise::SessionsController
	
	
	def create
		self.resource = warden.authenticate!(auth_options)
		set_flash_message(:notice, :signed_in) if is_navigational_format?
		sign_in(resource_name, resource);
		check_absent = current_user.absents.where({categories: 1, date: Date.today})
		if check_absent.empty?
			current_user.absents.create({categories: 1, date: Date.today, time_in: Time.now })
		end
		respond_with resource, :location => after_sign_in_path_for(resource)
	end
end