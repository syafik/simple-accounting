
class SettingsController < ApplicationController
	def overtime

	end

	def overtime_create
		Setting[:startlimitdaytime] = params[:startlimitdaytime]
		Setting[:startlimitnighttime] = params[:startlimitnighttime]
		Setting[:maxovertimeperday] = params[:maxovertimeperday]
		redirect_to overtime_setting_path
	end

	def jamsostek

	end

	def jamsostek_create
		Setting[:jamsostek] = params[:jamsostek]
		redirect_to jamsostek_setting_path
	end

end
