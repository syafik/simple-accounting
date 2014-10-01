
class SettingsController < ApplicationController
	def overtime

	end

	def overtime_create
		Setting[:startlimitdaytime] = params[:startlimitdaytime]
		Setting[:startlimitnighttime] = params[:startlimitnighttime]
	end

end
