$(function() {
	$(document).ready(function() {
		document.title += ' - 예약 목록';
		
		$(".bookingToOrderButton").on("click", function() {
			var trIdx = $(this).closest("tr").prevAll().length;
			console.log(trIdx);
		});
		
		setFilteringPaging();
	});
	
	$("#selectAll").click(function(){
		$("input[type=checkbox]").prop("checked", true);
		$("input[type=checkbox]:checked").closest("tr").addClass("table-primary");
	});
	
	$("#deselectAll").click(function(){
		$("input[type=checkbox]:checked").closest("tr").removeClass("table-primary");
		$("input[type=checkbox]").prop("checked", false);
	});
	
	$("input[type=checkbox]").click(function() {
		console.log("눌림");
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
		
		if(cntPerPage != null) {
			$("select[name=cntPerPage]").val(cntPerPage);
		}
		if(where.length != 0) {
			$("select[name=where]").val(where);
			$("input[name=query]").val(query);
		}
		if(sorter.length != 0) {
			$("select[name=sorter]").val(sorter);
		}
		if(designer.length != 0) {
			$("select[name=designer]").val(designer);
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
});