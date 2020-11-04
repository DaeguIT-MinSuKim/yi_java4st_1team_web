$(function() {
	$(document).ready(function() {
		document.title += ' - 예약 목록';
		setFilteringPaging();
	});	
	
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
		wantDate.setMonth(wantDate.getMonth() + 1);
		wantDate.setDate(wantDate.getDate() - 1);
		
		$("#startDate").datepicker("update", dateToString(today));
		$("#endDate").datepicker("update", dateToString(wantDate));
	});
});


function setDateValue(days) {
	var today = new Date();
	var wantDate = new Date();
	wantDate.setDate(wantDate.getDate() + days);
	
	$("#startDate").datepicker("update", dateToString(today));
	$("#endDate").datepicker("update", dateToString(wantDate));
};

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
};
	
$(function(){
	$("#selectAll").click(function(){
		console.log($(".ckbox"));
		$(".ckbox").prop("checked", true);
		$(".ckbox:checked").closest("tr").addClass("table-primary");
	});

	$("#deselectAll").click(function(){
		$(".ckbox:checked").closest("tr").removeClass("table-primary");
		$(".ckbox").prop("checked", false);
	});

	$(".ckbox").click(function() {
		if($(this).is(":checked")) {
			$(this).closest("tr").addClass("table-primary");
		} else {
			$(this).closest("tr").removeClass("table-primary");
		}
	});
	
	$("#deleteSelected").click(function() {
	    console.log($("input[type=checkbox]:checked").attr("no"));
	    var checkedList = new Array();
	    $("input[type=checkbox]:checked").each(function() {
	    	checkedList.push(this.value);
	    });
	    console.log(checkedList);
	    
	    if(!checkedList) {
	    	alert("예약을 취소할 예약건을 선택하세요.");
	    	return;
	    }
	    
	    if(confirm("선택한 예약건(" + checkedList.length + "건)을 예약취소 하시겠습니까?") == true) {
	    	$.ajax({
		  		  type:'post',
		  		  url:'bookingCancle.do',
		  		  data: {list: checkedList},
		  		  dataType: "text",
		  		  success:function(data){
		  			  alert("예약이 취소 되었습니다. (" + checkedList.length + "건)");
		  			  location.reload();
		  		  },
		  		  error:function(data){
		  			  alert("예약을 취소하는데 실패했습니다.");
		  			  console.log(data);
		  		  }
		     	});
	    }
	});
})

/*$(document).on("click", "#selectAll", function(){
	console.log($(".ckbox"));
	$(".ckbox").prop("checked", true);
	$(".ckbox:checked").closest("tr").addClass("table-primary");
});

$(document).on("click", "#deselectAll", function(){
	$(".ckbox:checked").closest("tr").removeClass("table-primary");
	$(".ckbox").prop("checked", false);
});

$(document).on("click", ".ckbox", function() {
	if($(this).is(":checked")) {
		$(this).closest("tr").addClass("table-primary");
	} else {
		$(this).closest("tr").removeClass("table-primary");
	}
});*/



$(document).on('click', '.deleteButton', function() {
	event.preventDefault();
	console.log($(this).attr('href'));
    var res = confirm("예약 취소 하시겠습니까?");
	
    if (res == true)   { 
    	$.ajax({
    		url: $(this).attr('href'),
    		type: "get",
    		dataType: "text",
    		success: function(data) {
    			if(data == 1) {
    				alert("예약 취소되었습니다.");
    			} else {
    				alert("문제가 발생했습니다. 다시 시도해주세요.");
    			}
    			location.reload();
    		},
    		error: function(error) {
    			alert("에러 발생");
    			location.reload();
    		}
    	});
    }
});


$("#searchBtn").click(function(e) {
	if($("select[name=where]").val() == undefined || $("input[name=query]").val() == "") {
		e.preventDefault();
	}
});
 
$("select[name=cntPerPage]").change(function(){
	document.searchForm.submit();
});

$("select[name=sorter]").change(function(){
	document.searchForm.submit();
});

$("select[name=designer]").change(function(){
	document.searchForm.submit();
});

function setFilteringPaging() {
	
	var thisUrlStr = window.location.href;
	
	var thisUrl = new URL(thisUrlStr);

	var where = thisUrl.searchParams.get("where");
	var query = thisUrl.searchParams.get("query");
	var cntPerPage = thisUrl.searchParams.get("cntPerPage");
	var sorter = thisUrl.searchParams.get("sorter");
	var designer = thisUrl.searchParams.get("designer");
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
//		$("#startDate").val(startDate);
		$("#startDate").datepicker("update", startDate);
	}
	if(!endDate) {
	} else if(endDate.length != 0) {
//		$("#endDate").val(endDate);
		$("#endDate").datepicker("update", endDate);
	}
}

/* function getFilteringPaging() {
	var params = "";
	var cntPerPage = $("select[name=cntPerPage]").val();
	var where = $("select[name=where]").val();
	var query = $("input[name=query]").val();
	
	console.log("1: " + params);
	if(cntPerPage != undefined) {
		if(params.length == 0) {
			params += "?";
		} else {
			params += "&";
		}
		params += "cntPerPage=" + cntPerPage;
		console.log("2: " + params);
	}
	
	if(where != null && where.length != 0 && query != null && query.length) {
		if(params.length == 0) {
			params += "?";
		} else if(params.length >= 1) {
			params += "&";
		} 
		params += "where=" + where + "&query=" + query;
		console.log("3: " + params);
	}
	
	location.href="bookingList.do" + params;
} */