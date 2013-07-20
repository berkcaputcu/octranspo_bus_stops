
var selectCount = 0;
var loadingCount = 0;

function addFromList(stop_id, route_id) {
	getStop(stop_id, route_id);
}

function getStopByCode (stop_code) {

	$.ajax({
		url: "/stops/search.json",
		method: "POST",
		data: {"stop_code": stop_code},
		success: function (data) {
			getStop(data.id);
		}
	});

}

function getStop(stop_id, route_id) {

	if (selectCount >= 10) {
		alert("Cannot add more than 10 stops.");
	} else {
		$.ajax({
			url: "/stops/" + stop_id + ".json",
			beforeSend: function () {
				loadingCount++;
				$('#loading_indicator').removeClass("hidden");
			},
			success: function (data) {

				var optionsArray = [];
				$.each(data.routes, function(index, value) {
					optionsArray.push("<option value='" + stop_id + ", " + value.id + "' " + ((route_id&&route_id==value.id)?"selected":"") + ">" + value.no + " - " + value.direction + "</option>");
				});

				var tableRowHTML = "<tr><td>Stop " + (selectCount+1) + "</td><td>" + data.code + "</td><td>" + data.name + "</td><td><select id='routes' name='routes[]'>" + optionsArray.join() + "</select></td></tr>";

				selectCount++;

				$(tableRowHTML).hide().appendTo('#selected_stops_table > tbody:last').fadeIn();

				enableNextButton();
			},
			complete: function () {
				if (--loadingCount <= 0) {
					$('#loading_indicator').addClass("hidden");	
				}
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