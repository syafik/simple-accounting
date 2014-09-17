
class OvertimePaymentHistoriesController < ApplicationController
	def index
		@oph = OvertimePaymentHistory.order("date asc")
	end
end
