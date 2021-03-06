<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 



<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">고객 예약 내역 </h1>
<p class="mb-4">
	<a target="_blank" href="https://datatables.net"></a>
</p>
<form method="post" name="formm">
<!-- DataTales Example -->
<div class="card shadow mb-4" style="width:1100px">
	<div class="card-header py-2">
		<h6 class="m-1 font-weight-bold text-primary" style="line-height: 16px; font-size: 1.3em">
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body">
		<div class="table-responsive">

<!-- 예약내역 -->

<table class="board">
	<tr>
		<th>번호</th> <th>이용날짜</th> <th>시술 정보</th> <th>총 금액</th> <th>예약상태</th> <th>예약등록일</th> <th></th>
	</tr>
	<c:choose>
		<c:when test="${message == -1}">
			 <tr><td colspan="6">예약건이 존재하지 않습니다.<td></tr>		
		 </c:when>
	</c:choose>
	
	<c:forEach var="booking" items="${booking}" varStatus="status">
 	<tr>
 		<td class="book_index"> ${total - ((paging.nowPage-1) * cnt + status.index)}
 		<input type="hidden" value="${booking.bookNo}" name="no">
 		</td>
 		<td class="book_date">
			<fmt:parseDate value="${booking.bookDate}" pattern="yyyy-MM-dd'T'HH:mm" var="bookDate" type="both" />
			<fmt:formatDate value="${bookDate}" pattern="yyyy-MM-dd HH:mm" />
		</td>
		<td class="book_name" onclick="location.href='bookingDetail.do?no=${booking.bookNo}'" style="cursor:pointer;" class="mypage_title">
			<c:if test="${booking.hairList.size() == 1}">
				${booking.hairList.get(0).hair.hairName}
			</c:if>
			<c:if test="${booking.hairList.size() != 1}">
			${booking.hairList.get(0).hair.hairName} 외  ${fn:length(booking.hairList)-1}건
			</c:if>
		</td>
		<td class="book_price">
			<fmt:formatNumber value="${pp.get(status.index)}" pattern="#,###" />
		</td>
		<td class="book_status">${booking.bookStatusStr}</td>
		<td class="book_reg">
			<fmt:parseDate value="${booking.bookRegDate}" pattern="yyyy-MM-dd'T'HH:mm" var="bookReg" type="both" />
			<fmt:formatDate value="${bookReg}" pattern="yyyy-MM-dd HH:mm" />
		</td>
		<td class="book_reg" style="clear:both">
			<c:if test="${booking.bookStatus == 1}">
				<input type="button" value="주문 전환" class="btn btn-dark btn-sm" onclick="location.href='bookingToOrder.do?no=${booking.bookNo}'">
			</c:if>
			<c:if test="${booking.bookStatus == 0}">
				<input type="button" value="주문 전환" class="btn btn-dark btn-sm" disabled>
			</c:if>
		</td>
	</tr>
	</c:forEach>
</table>



<div class="paging">
			<c:if test="${paging.startPage != 1}">
				<a href="guestBookingInfo.do?id=${id}&nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}"><i class="xi-angle-left"></i></a>	
			</c:if>
			&nbsp;&nbsp;
			<c:forEach begin="${paging.startPage}" end="${paging.endPage }" var="p">
				<c:choose>
					<c:when test="${p == paging.nowPage }">
					${p}
					</c:when>
					<c:when test="${p != paging.nowPage }">
						<a href="guestBookingInfo.do?id=${id}&nowPage=${p}&cntPerPage=${paging.cntPerPage}"><b style="margin:5px;">${p}</b></a>
					</c:when>
				</c:choose>
			</c:forEach>
			&nbsp;&nbsp;
			<c:if test="${paging.endPage != paging.lastPage }">
				<a href="guestBookingInfo.do?${id}&nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}"><i class="xi-angle-right"></i></a>
			</c:if>	
		</div>
	<div class="onb-buttons">
			<input type="button" value="목록" onclick="location.href='guestList.do'" class="btn btn-primary btn-sm"> 
	</div>
	
</div>


</div></div></form>
<%@ include file="../include/footer.jsp" %>


