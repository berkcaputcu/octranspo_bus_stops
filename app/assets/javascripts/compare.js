
var selectCount = 0

function addFromFavorites(stop_id, route_id) {
	getStop(stop_id, route_id);
}

function getStop(stop_id, route_id) {

	if (selectCount >= 10) {
		alert("Cannot add more than 10 stops.");
	} else {
		$.ajax({
			url: "/stops/" + stop_id + ".json",
			beforeSend: function () {
				$('#loading_indicator').removeClass("hidden");
			},
			success: function (data) {

				var optionsArray = [];
				$.each(data.routes, function(index, value) {
					optionsArray.push("<option value='" + value.id + "' " + ((route_id&&route_id==value.id)?"selected":"") + ">" + value.no + " - " + value.direction + "</option>");
				});

				var tableRowHTML = "<tr><td>Stop " + (++selectCount) + "</td><td>" + data.code + "</td><td>" + data.name + "</td><td><select id='routes_" + stop_id + "' name='routes[" + stop_id + "]'>" + optionsArray.join() + "</select></td></tr>";

				$(tableRowHTML).hide().appendTo('#selected_stops_table > tbody:last').fadeIn();

				enableNextButton();
			},
			complete: function () {
				$('#loading_indicator').addClass("hidden");
			}
		});
	}

}

function enableNextButton() {
	$('#stops_form_submit').removeClass("disabled");
	$('#stops_form_submit').removeAttr("disabled");
}

function resetCount() {
	selectCount = 0;
}