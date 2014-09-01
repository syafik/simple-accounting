class SessionsController < Devise::SessionsController
	
	
	def create
		self.resource = warden.authenticate!(auth_options)
		set_flash_message(:notice, :signed_in) if is_navigational_format?
		sign_in(resource_name, resource);
		current_user.absents.create({categories: 1, date: Date.today })
		respond_with resource, :location => after_sign_in_path_for(resource)
	end
end