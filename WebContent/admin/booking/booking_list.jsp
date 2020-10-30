<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../include/header.jsp"%>
<script>
$(function() {
	$(document).ready(function() {
		document.title += ' - 예약 목록';
		
		$(".bookingToOrderButton").on("click", function() {
			var trIdx = $(this).closest("tr").prevAll().length;
			console.log(trIdx);
		});
		
		setFilteringPaging();
	});
	
	$('.delete').click(function(event) {
	    

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
	
	function setFilteringPaging() {
		var thisUrlStr = window.location.href;
		var thisUrl = new URL(thisUrlStr);

		var where = thisUrl.searchParams.get("where");
		var query = thisUrl.searchParams.get("query");
		var cntPerPage = thisUrl.searchParams.get("cntPerPage");
		var sorter = thisUrl.searchParams.get("sorter");
		
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
	}
	
	function getFilteringPaging() {
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
	}
});
</script>
<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">목록 템플릿</h1>
<p class="mb-4">
	여기에 간단한 설명 추가해주세요. 이렇게 링크도 달아도 됩니다. <a target="_blank"
		href="https://datatables.net">링크</a>
</p>

<!-- DataTales Example -->
<div class="card shadow mb-4">
	<div class="card-header py-2">
		<h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
			<div class="mt-2 float-left">
             	예약 내역 목록
            </div>
            <div class="float-right">
				<button id="addNew" class="btn btn-success btn-sm" style="float: right;">등록</button>
	           	<button id="deleteSelected"class="btn btn-danger btn-sm" style="float: right; margin-right: 10px;">선택삭제</button>
				<button id="selectAll" class="btn btn-secondary btn-sm" style="float: right;  margin-right: 10px;">전체선택</button>
				<button id="deselect" class="btn btn-outline-secondary btn-sm" style="float: right;  margin-right: 10px;">선택해제</button>
            </div>			
		</h6>
		<!-- <h6 class="m-1 font-weight-bold text-primary" style="line-height: 16px; font-size: 1.3em">
		
			예약 내역
			<a href="#" id="deleteSelected"class="btn btn-danger btn-sm" style="float: right;"><span class="text">삭제</span></a>
			<a href="#" id="addNew" class="btn btn-success btn-sm" style="float: right;  margin-right: 10px;"><span class="text">등록</span></a>
			<a href="#" id="selectAll" class="btn btn-secondary btn-sm" style="float: right;  margin-right: 10px;"><span class="text">전체선택</span></a>
			<a href="#" id="deselect" class="btn btn-outline-secondary btn-sm" style="float: right;  margin-right: 10px;"><span class="text">선택해제</span></a>
		</h6> -->
	</div>
	<!-- card-body -->
	<div class="card-body">
		<div class="table-responsive">
			<!-- bootStrap table wrapper-->
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
				<!-- 테이블 상단 필터링 시작 -->
				<form action="bookingList.do" name="searchForm">
						
				<div class="row m-0 mb-2">
					<div class="col-sm-12 col-md-6 p-0">
						<div class="dataTables_length form-inline" id="dataTable_length">
							<div class="input-group input-group-sm mr-3">
								<select name="cntPerPage" aria-controls="dataTable" class="custom-select custom-select-sm">
									<option value="10">10줄 보기</option>
									<option value="25">25줄 보기</option>
									<option value="50">50줄 보기</option>
									<option value="100">100줄 보기</option>
								</select>
							</div>
							<div class="input-group input-group-sm">
								<div class="input-group-sm input-group-prepend">
									<label class="input-group-text" for="sorter">구분</label>
								</div>
								<select name="sorter" aria-controls="dataTable" class="custom-select custom-select-sm">
									<option selected value="">전체</option>
									<option value="1">예약완료</option>
									<option value="2">주문완료</option>
									<option value="0">예약취소</option>
									<option value="-1">미방문</option>
								</select>
							</div>
						</div>
					</div>
					<div class="col-sm-12 col-md-6 p-0">
						<div id="dataTable_filter" class="dataTables_filter ">
							<select class="custom-select custom-select-sm" name="where" style="width: 80px;">
								<option value="">기준</option>
								<option value="guestId">아이디</option>
								<option value="guestName">고객명</option>
								<option value="guestPhone">연락처</option>
							</select>
							<label>
								<input type="search" class="form-control form-control-sm" name="query" placeholder="" aria-controls="dataTable">
							</label>
							<input type="submit" class="btn btn-primary btn-sm" value="검색" id="searchBtn"></input>
						</div>
					</div>
				</div>
				</form>
				<!-- 테이블 상단 필터링 끝 -->
				<!-- 테이블 시작 -->
				<table class="table table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
					<thead>
						<tr>
							<th>선택</th>
							<th>예약번호</th>
							<th>예약일시</th>
							<th>담당 디자이너</th>
							<th>고객명</th>
							<th>연락처</th>
							<th>시술</th>
							<th>예약상태</th>
							<th>예약등록일</th>
							<th style="width: 100px; min-width:100px; max-width:100px;">상세보기</th>
							<th style="width: 180px; min-width:180px; max-width:180px;"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="booking" items="${list }">
						<tr>
							<td><input type="checkbox" no="${booking.bookNo }"></td>
							<td>${booking.bookNo }</td>
							<td>${booking.bookDateStr }</td>
							<td>${booking.designer.deName }</td>
							<td>${booking.guest.guestName } (${booking.guest.guestId })</td>
							<td>${booking.guest.guestPhone }</td>
							<td>${booking.howManyHairItems }</td>
							<td>${booking.bookStatusStr }</td>
							<td>${booking.bookRegDateStr }</td>
							<td>
								<a href="bookingDetail.do?no=${booking.bookNo}" class="btn bg-gray-200 btn-sm detailViewButton"><span class="text-gray-800">상세보기</span></a>
							</td>
							<td>
								<c:if test="${booking.bookStatus eq 1}">
									<a href="orderForm.do?no=${booking.bookNo }" class="btn bg-warning btn-sm bookingToOrderButton"><span class="text-gray-800">주문하기</span></a>
									<a href="bookingCancle.do?no=${booking.bookNo }" class="btn btn-danger btn-sm deleteButton" bookNo="${booking.bookNo }"><span class="text">예약 취소</span> </a>
								</c:if>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- 테이블 끝 -->
				
				<!-- 페이징 시작 -->
				<div class="row">
					<div class="col-sm-12 col-md-5">
						<div class="dataTables_info" id="dataTable_info" role="status" aria-live="polite">전체 ${total }개 중 ${cntPerPage*(nowPage-1) + 1} - ${nowPage > (total/cntPerPage) ? (nowPage-1)*cntPerPage + total%cntPerPage : nowPage*cntPerPage}</div>
					</div>
					<div class="col-sm-12 col-md-7">
						<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
							<ul class="pagination">
								<li class="paginate_button page-item previous disabled" id="dataTable_previous">
									<a href="#" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">이전</a></li>
								<li class="paginate_button page-item active">
									<a href="#" aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
								<li class="paginate_button page-item ">
									<a href="#" aria-controls="dataTable" data-dt-idx="2" tabindex="0" class="page-link">2</a></li>
								<li class="paginate_button page-item ">
									<a href="#" aria-controls="dataTable" data-dt-idx="3" tabindex="0" class="page-link">3</a></li>
								<li class="paginate_button page-item next" id="dataTable_next">
									<a href="#" aria-controls="dataTable" data-dt-idx="4" tabindex="0" class="page-link">다음</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
				<!-- 페이징 -->
			</div>
			<!-- bootStrap table wrapper-->
		</div>
		<!-- tableRespnsible -->
	</div>
	<!-- cardBody-->
	<div class="card-footer">
			ㅎㅇㅎㅇ
	</div>
</div>

<%@ include file="../include/footer.jsp"%>