module TasksHelper
	def translate_urgency_importance(num)
		urgency_importance_options=["Low", "Middle", "High"]
		urgency_importance_options[num]
	end

	def translate_status(num)
		status_options=["Not yet", "WIP", "Done"]
		status_options[num]
	end


end
