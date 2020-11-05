$(function() {
	$(document).ready(function() {
		document.title += ' - 주문 목록';
		
		$(".bookingToOrderButton").on("click", function() {
			var trIdx = $(this).closest("tr").prevAll().length;
			console.log(trIdx);
		});
		
		$(document).on('click', '.deleteButton', function() {
			var idx = $(this).parents('tr:first').children("td").eq(1).text();
		    console.log(idx);
		});

		setFilteringPaging();
		
		$("#startDate").datepicker({
			format: "yyyy-mm-dd",
			language: "ko",
			todayBtn: "linked",
			clearBtn: true
		});
		
		$("#endDate").datepicker({
			format: "yyyy-mm-dd",
			language: "ko",
			todayBtn: "linked",
			clearBtn: true
		});
		
		$(".dateBtn").not("#aMonthBtn").click(function() {
			setDateValue($(this).val() - 1);
		});
		
		$("#aMonthBtn").click(function() {
			var today = new Date();
			var wantDate = new Date();
			wantDate.setMonth(wantDate.getMonth() - 1);
			wantDate.setDate(wantDate.getDate() + 1);
			
			$("#startDate").datepicker("update", dateToString(wantDate));
			$("#endDate").datepicker("update", dateToString(today));
		})
		
	});
	
	
	function setDateValue(days) {
		var today = new Date();
		var wantDate = new Date();
		wantDate.setDate(wantDate.getDate() - days);
		
		$("#startDate").datepicker("update", dateToString(wantDate));
		$("#endDate").datepicker("update", dateToString(today));
	}
	
	function dateToString(date) {
		var year = date.getFullYear(); 
		var month = new String(date.getMonth()+1); 
		var day = new String(date.getDate()); 

		// 한자리수일 경우 0을 채워준다. 
		if(month.length == 1){ 
		  month = "0" + month; 
		} 
		if(day.length == 1){ 
		  day = "0" + day; 
		} 
		
		return year + "-" + month + "-" + day;
	}
	
	function setFilteringPaging() {
		var thisUrlStr = window.location.href;
		var thisUrl = new URL(thisUrlStr);

		var cntPerPage = thisUrl.searchParams.get("cntPerPage");
		var where = thisUrl.searchParams.get("where");
		var query = thisUrl.searchParams.get("query");
		var designer = thisUrl.searchParams.get("designer");
		var membership = thisUrl.searchParams.get("membership");
		var startDate = thisUrl.searchParams.get("startDate");
		var endDate = thisUrl.searchParams.get("endDate");
		
		if(cntPerPage != null) {
			$("select[name=cntPerPage]").val(cntPerPage);
		}
		if(!where) {
		} else if(where.length != 0) {
			$("select[name=where]").val(where);
			$("input[name=query]").val(query);
		}
		if(!designer) {
		} else if(designer.length != 0) {
			$("select[name=designer]").val(designer);
		}
		if(!membership) {
		} else if(membership.length != 0) {
			$("select[name=membership]").val(membership);
		}
		if(!startDate) {
		} else if(startDate.length != 0) {
			$("select[name=startDate]").val(startDate);
		}
		if(!endDate) {
			$("#endDate").val(dateToString(new Date()));
			console.log("셋팅");
		} else if(endDate.length != 0) {
			$("select[name=endDate]").val(endDate);
		}
		console.log("endDate" + endDate);
	}
	
	$("#searchBtn").click(function(e) {
		if($("select[name=where]").val() == undefined || $("input[name=query]").val() == "") {
			e.preventDefault();
		}
	});
	 
	$("select[name=cntPerPage]").change(function(){
		document.searchForm.submit();
	});
	
	$("select[name=designer]").change(function(){
		document.searchForm.submit();
	});
	
});