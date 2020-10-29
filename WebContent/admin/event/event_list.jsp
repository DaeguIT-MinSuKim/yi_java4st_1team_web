<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>
<script>
	document.title += ' - 이벤트 목록'
</script>
<!-- Page Heading -->

<div class="d-sm-flex align-items-center justify-content-between mb-4">
  <h1 class="h3 mb-0 text-gray-800">이벤트 관리 - 이벤트 목록</h1>
</div>

<!-- Content Row -->

<form method="post" name="formm">
<!-- DataTales Example -->
<div class="card shadow mb-4">
	<div class="card-header py-2">
		<h6 class="m-1 font-weight-bold text-primary" style="line-height: 16px; font-size: 1.3em">
			
				<input type="button" value="등록" class="btn btn-info btn-sm" style="float: left;  margin-right: 10px;" onclick="location.href='guestAdd.do' ">
				<input type="button"  value="삭제" name="delete" class="btn btn-secondary btn-sm" style="float: left;" >
				
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
			※ 생일쿠폰 자동발급 할건지

				<!-- 테이블 상단 필터링 시작 -->
				<div class="row mb-2">
					<div class="col-sm-12 col-md-6">
						<div class="dataTables_length" id="dataTable_length">
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
							<th>이벤트명</th>
							<th>할인율</th>
							<th>시작일</th>
							<th>종료일</th>
							<th>내용</th>
							<th>상태</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="event" items="${list}" varStatus="status">
						<tr>
							<td><input type="checkbox" name="check" value="${guest.guestId}"></td>
							<td style="width:20px;"> ${total - ((paging.nowPage-1) * cnt + status.index)}</td>
							<td>${event.eventName}</td>
							<td> <fmt:parseNumber value="${event.eventSaleRate * 100}" integerOnly="true"/>%</td>
							<td>${event.eventStart}</td>
							<td>${event.eventEnd}</td>
							<td>${event.eventContent}</td>
							<td>
								<c:if test="${event.eventStatus == 's'}">
									<div class="btn-danger btn-sm" style="width:80px; margin:0 auto">진행중</div>
								</c:if>
								<c:if test="${event.eventStatus == 'e'}">
									<div class="btn-secondary btn-sm" style="width:80px; margin:0 auto">종료</div>
								</c:if>
								<c:if test="${event.eventStatus == 'w'}">
									<div class="btn-info btn-sm" style="width:80px; margin:0 auto">대기중</div>
								</c:if>
							</td>

							<td  style="width:100px;">
								<input type="button" name="update" value="수정" class="btn btn-primary btn-sm" onclick="location.href='guestInfo.do?id=${guest.guestId}'">
								<input type="button" value="삭제" id="btn_delete" guestId="${guest.guestId}" class="btn btn-primary btn-sm">
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- 테이블 끝 -->

	
					<!-- 페이징 시작 -->

					<div style="width:100%; text-align:center; display:inline-block; margin:0 auto;">
					<p>Total : ${total}</p>
					
						<!-- << -->
						<c:if test="${paging.startPage != 1}">
							<div class="paging-line">
							<a href="guestList.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}">
								<i class="fas fa-angle-double-left"></i>
							</a>
							</div>
						</c:if>
						<c:if test="${paging.startPage == 1}">
							<div class="paging-line">
								<i class="fas fa-angle-double-left"></i>
							</div>
						</c:if>
						
						
						<!-- 이전페이지 -->
						<c:choose>
							<c:when test="${paging.nowPage != 1}">
								<div class="paging-line">
									<a href="guestList.do?nowPage=${paging.nowPage-1}&cntPerPage=${paging.cntPerPage}"><i class="fas fa-angle-left"></i></a>
								</div>
							</c:when>
							<c:when test="${paging.nowPage == 1}">
								<div class="paging-line">
									<i class="fas fa-angle-left"></i>
								</div>
							</c:when>
						
						</c:choose>
						
						<!-- 페이지 숫자 -->
						
						<c:forEach begin="${paging.startPage}" end="${paging.endPage }"
							var="p">
							<c:choose>
								<c:when test="${p == paging.nowPage }">
									<div class="paging-line" style="font-weight:bold">${p}</div>
								</c:when>
								<c:when test="${p != paging.nowPage }">
									<div class="paging-line">
									<a href="guestList.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}">
									${p}</a></div>
								</c:when>
							</c:choose>
						</c:forEach>
						
						
						
						<!-- 다음페이지 -->
						<c:choose>
							<c:when test="${paging.nowPage != paging.lastPage}">
								<div class="paging-line">
									<a href="guestList.do?nowPage=${paging.nowPage+1}&cntPerPage=${paging.cntPerPage}"><i class="fas fa-angle-right"></i></a>
								</div>
							</c:when>
							<c:when test="${paging.nowPage == paging.lastPage}">
								<div class="paging-line">
									<i class="fas fa-angle-right"></i>
								</div>	
							</c:when>
						
						</c:choose>	
						
						<!-- >> -->
						
					
						<c:if test="${paging.endPage != paging.lastPage }">
							<div class="paging-line">
							<a href="guestList.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">
							<i class="fas fa-angle-double-right"></i></a>
							</div>
						</c:if>
						<c:if test="${paging.endPage == paging.lastPage }">
							<div class="paging-line">
							<i class="fas fa-angle-double-right"></i>
							</div>
						</c:if>
					
			
					</div>
				</div>
				<!-- bootStrap table wrapper-->
			</div>
			<!-- tableRespnsible -->
		</div>
		<!-- cardBody-->
	</div>

</form>


<%@ include file="../include/footer.jsp" %>   