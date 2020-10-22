<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<script>
document.title += ' - 고객 목록';
	
function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href="guestList.do?nowPage=1&cntPerPage="+sel;
};

function selectAll(){
	$('[name=check]').prop('checked', true);
};

function deselectAll(){
	$('[name=check]').prop('checked', false);
};

</script>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">고객 목록 - 고객 관리</h1>
<p class="mb-4">
	<a target="_blank" href="https://datatables.net"></a>
</p>
<form method="post" name="formm">
<!-- DataTales Example -->
<div class="card shadow mb-4">
	<div class="card-header py-2">
		<h6 class="m-1 font-weight-bold text-primary" style="line-height: 16px; font-size: 1.3em">
			
			<!--  <a href="#" id="deleteSelected"class="btn btn-danger btn-sm" style="float: right;"><span class="text">삭제</span></a>-->
			<a href="#" id="addNew" class="btn btn-success btn-sm" style="float: left;  margin-right: 10px;"><span class="text">고객  등록</span></a>
				<button type="button" onclick="selectAll()" class="btn btn-secondary btn-sm" style="float: right;  margin-right: 10px;">
					전체선택
				</button>
				<button type="button" onclick="deselectAll()" class="btn btn-outline-secondary btn-sm" style="float: right;  margin-right: 10px;">
					선택해제
				</button>
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body">
		<div class="table-responsive">
			<!-- bootStrap table wrapper-->
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">

				<!-- 테이블 상단 필터링 시작 -->
				<div class="row mb-2">
					<div class="col-sm-12 col-md-6">
						<div class="dataTables_length" id="dataTable_length">
							<label>
							<select name="dataTable_length" id="cntPerPage" onchange="selChange()"aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm">
									<option value="5"
						<c:if test="${paging.cntPerPage == 5}">selected</c:if>>5줄 보기</option>
							<option value="10"
								<c:if test="${paging.cntPerPage == 10}">selected</c:if>>10줄 보기</option>
							<option value="15"
								<c:if test="${paging.cntPerPage == 15}">selected</c:if>>15줄 보기</option>
							<option value="20"
								<c:if test="${paging.cntPerPage == 20}">selected</c:if>>20줄 보기</option>
							</select>
							</label>
						</div>
					</div>
					<div class="col-sm-12 col-md-6">
						<div id="dataTable_filter" class="dataTables_filter ">
							<select class="custom-select custom-select-sm" name="opt" style="width: 80px;">
								<option value="1">고객명</option>
								<option value="0">아이디</option>
							</select>
							<label>
								<input type="text" name="value" class="form-control form-control-sm" placeholder="" aria-controls="dataTable">
							</label>
							<input type="submit" value="검색" class="btn btn-primary btn-sm">
						</div>
					</div>
				</div>
				<!-- 테이블 상단 필터링 끝 -->

				<!-- 테이블 시작 -->
				<table class="table table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
					<thead>
						<tr>
							<th></th>
							<th></th>
							<th>아이디</th>
							<th>고객명</th>
							<th>생년월일</th>
							<th>연락처</th>
							<th>이메일</th>
							<th>성별</th>
							<th>가입일</th>
							<th>비고</th>
							<th>탈퇴</th>
							<th>정보동의</th>
							<th>주문 전환</th>
							<th>상세보기</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="guest" items="${list}" varStatus="status">
						<tr>
							<td><input type="checkbox" name="check" value="${guest.guestId}"></td>
							<td style="width:30px;"> ${total - ((paging.nowPage-1) * cnt + status.index)}</td>
							<td style="width:100px;">${guest.guestId}</td>
							<td style="width:100px;">${guest.guestName }</td>
							<td style="width:130px;">${guest.guestBirthday}</td>
							<td style="width:150px;">${guest.guestPhone}</td>
							<td style="width:200px;">${guest.guestEmail}</td>
							<td style="width:50px;">
							<c:if test="${guest.guestGender == 0}">여</c:if>
							<c:if test="${guest.guestGender == 1}">남</c:if>
							</td>
							<td style="width:180px;">
								<fmt:parseDate value="${guest.guestJoinDate}" pattern="yyyy-MM-dd'T'HH:mm" var="join" type="both" />
								<fmt:formatDate value="${join}" pattern="yyyy-MM-dd HH:mm" />
								
								</td>
							<td style="width:200px;">${guest.guestNote}</td>
							<td style="width:60px;">${guest.delYn}</td>
							<td style="width:80px;">${guest.infoYn}</td>
							<td style="width:100px;">
								<a href="#" class="btn bg-warning btn-sm bookingToOrderButton"><span class="text-gray-800">주문</span></a>
							</td>
							<td>
								<input type="hidden" name="id" value="${guest.guestId}">
								
								<input type="button" name="info" value="시술정보" class="btn bg-gray-200 btn-sm detailViewButton" onclick="location.href='guestOnBInfo.do?id=${guest.guestId}'">
								<input type="button" name="info" value="회원정보" class="btn bg-gray-200 btn-sm detailViewButton" onclick="location.href='guestInfo.do?id=${guest.guestId}'">
								
								
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- 테이블 끝 -->
				
				
				
				
				<!-- 페이징 시작 -->
			<div class="row">
					<div class="col-sm-12 col-md-5">
						<%-- <div class="dataTables_info" id="dataTable_info" role="status"
							aria-live="polite">Total : ${total} </div> --%>
					</div>
				<%-- 	<div class="col-sm-12 col-md-7">
						<div class="dataTables_paginate paging_simple_numbers"
							id="dataTable_paginate">
							<ul class="pagination">
								<li class="paginate_button page-item previous disabled"
									id="dataTable_previous">
									<a href="guestList.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}"
									aria-controls="dataTable" data-dt-idx="0" tabindex="0"
									class="page-link">이전</a></li>
			
								
								<li class="paginate_button page-item active">
								
								<a href="#" aria-controls="dataTable" data-dt-idx="1" tabindex="0"
									class="page-link">1</a></li>
								
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="2" tabindex="0"
									class="page-link">2</a></li>
								
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="3" tabindex="0" 
									class="page-link">3</a></li>
								
								<li class="paginate_button page-item next" id="dataTable_next">
									<a href="guestList.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}" 
									aria-controls="dataTable" data-dt-idx="4"
									tabindex="0" class="page-link">다음</a>
								</li>
							</ul> --%>
						</div>
					</div> 
					<!-- 페이징 -->

					<div style="text-align:center; float:center;">
					<p>Total : ${total}</p>
						
						
						<c:if test="${paging.startPage != 1}">
							<a href="guestList.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}">
							<i class="xi-angle-left"></i></a>
						</c:if>
						
						<c:forEach begin="${paging.startPage}" end="${paging.endPage }"
							var="p">
							<c:choose>
								<c:when test="${p == paging.nowPage }">
								${p}
								</c:when>
								<c:when test="${p != paging.nowPage }">
									<a href="guestList.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}"><b
										style="margin: 5px;">${p}</b></a>
								</c:when>
							</c:choose>
						</c:forEach>
					
						&nbsp;&nbsp;
						<c:if test="${paging.endPage != paging.lastPage }">
							<a href="guestList.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">
							<i class="xi-angle-right"></i></a>
						</c:if>
						
						
					</div>
				</div>
				<!-- bootStrap table wrapper-->
			</div>
			<!-- tableRespnsible -->
		</div>
		<!-- cardBody-->
<!-- 	</div>
</div> -->
</form>
<%@ include file="../include/footer.jsp" %>   