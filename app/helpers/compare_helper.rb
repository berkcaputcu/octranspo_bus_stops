module CompareHelper

	def label_for adjusted_time
		if adjusted_time.live?
			"<span class='label label-success'>Live</span>".html_safe
		else
			"<span class='label label-important'>Scheduled</span>".html_safe
		end
	end

	def show_age adjusted_time
		if adjusted_time.live?
			"#{number_with_precision adjusted_time.age_in_seconds, precision: 2}s"
		else
			" - "
		end
	end

	def favorite_button stop_time
		if user_signed_in?
			link_to_function "<i class='icon-star'></i> Add to favorites".html_safe, "addToFavorites(#{stop_time.id})", class: "btn btn-small pull-right"
		else
			button_tag "<i class='icon-star'></i> Add to favorites".html_safe, class: "btn btn-small pull-right disabled", disabled: true, title: "You must be signed in."
		end
	end

end
