module CompareHelper

	def label_for adjusted_time
		if adjusted_time.live?
			"<span class='label label-success'>Live</span>".html_safe
		else
			"<span class='label label-warning'>Scheduled</span>".html_safe
		end
	end

	def show_age adjusted_time
		if adjusted_time.live?
			"#{number_with_precision adjusted_time.age_in_seconds, precision: 2}s ago"
		else
			" - "
		end
	end

end
