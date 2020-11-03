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
		
		$("#todayBtn").click(function() {
			$("#startDate").val();
			$("#endDate").val();
		})
		
		$("#aWeekBtn").click(function() {
		})
		
		$("#twoWeeksBtn").click(function() {
			
		})
		
		$("#aMonthBtn").click(function() {
			
		})
	});
	
	
	function setDateDuration(startDate, endDate) {
		
	}
	
	
	function setFilteringPaging() {
		var thisUrlStr = window.location.href;
		var thisUrl = new URL(thisUrlStr);

		var where = thisUrl.searchParams.get("where");
		var query = thisUrl.searchParams.get("query");
		var cntPerPage = thisUrl.searchParams.get("cntPerPage");
		var designer = thisUrl.searchParams.get("designer");
		
		if(cntPerPage != null) {
			$("select[name=cntPerPage]").val(cntPerPage);
		}
		if(!where) {
		} else if(where.length != 0) {
			$("select[name=where]").val(where);
			$("input[name=query]").val(query);
		}
		if(!sorter) {
		} else if (sorter.length != 0) {
			$("select[name=sorter]").val(sorter);
		}
		if(!designer) {
		} else if(designer.length != 0) {
			$("select[name=designer]").val(designer);
		}
		if(!startDate) {
		} else if(startDate.length != 0) {
			$("select[name=startDate]").val(startDate);
		}
		if(!endDate) {
		} else if(endDate.length != 0) {
			$("select[name=endDate]").val(endDate);
		}
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