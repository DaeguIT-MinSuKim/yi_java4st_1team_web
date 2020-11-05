$(function() {
	$("#startDate").datepicker({
		format : "yyyy-mm-dd",
		language : "ko",
		todayBtn : "linked",
		clearBtn : true
	});

	$("#endDate").datepicker({
		format : "yyyy-mm-dd",
		language : "ko",
		todayBtn : "linked",
		clearBtn : true
	});

	$(".dateBtn").not("#aMonthBtn").click(function() {
		setDateValue($(this).val() - 1);
	});

	$("#aMonthBtn").click(function() {
		var today = new Date();
		var wantDate = new Date();
		wantDate.setMonth(wantDate.getMonth() - 1);
		wantDate.setDate(wantDate.getDate() + 1);

		$("#startDate").datepicker("update", dateToString(today));
		$("#endDate").datepicker("update", dateToString(wantDate));
	});
});

function setDateValue(days) {
	var today = new Date();
	var wantDate = new Date();
	wantDate.setDate(wantDate.getDate() - days);

	$("#startDate").datepicker("update", dateToString(today));
	$("#endDate").datepicker("update", dateToString(wantDate));
};

function dateToString(date) {
	var year = date.getFullYear();
	var month = new String(date.getMonth() + 1);
	var day = new String(date.getDate());

	// 한자리수일 경우 0을 채워준다.
	if (month.length == 1) {
		month = "0" + month;
	}
	if (day.length == 1) {
		day = "0" + day;
	}

	return year + "-" + month + "-" + day;
};