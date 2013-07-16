// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .



function addToFavorites (stop_time_id) {

	$.ajax({
		url: "/favorites.json",
		type: "POST",
		data: { 'stop_time_id': stop_time_id },
		success: function () {
			$("#fav_" + stop_time_id).attr("title", "Remove from favorites");
			$("#fav_" + stop_time_id).attr("onclick", "removeFromFavorites(" + stop_time_id + ")");
			$("#fav_" + stop_time_id + " i").removeClass("icon-star-empty").addClass("icon-star");
		}
	});

}

function removeFromFavorites (stop_time_id) {

	$.ajax({
		url: "/favorites.json",
		type: "DELETE",
		data: { 'stop_time_id': stop_time_id },
		success: function () {
			$("#fav_" + stop_time_id).attr("title", "Add to favorites");
			$("#fav_" + stop_time_id).attr("onclick", "addToFavorites(" + stop_time_id + ")");
			$("#fav_" + stop_time_id + " i").removeClass("icon-star").addClass("icon-star-empty");
		}
	});

}