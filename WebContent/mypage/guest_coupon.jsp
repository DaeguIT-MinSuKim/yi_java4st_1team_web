<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ include file="../header.jsp" %>  
     <%@ include file="sub_menu.jsp" %>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<style>
.coupon a {background-color:white;  border-bottom:1px solid white;}
</style>   
<body>
<div class="book_wrapper">
<h3 style="text-align:center; padding:20px; margin-bottom:50px;">MY COUPON</h3>
<table id="board">
		<tr>
			 <th>번호</th> <th>쿠폰명</th> <th>쿠폰 기간</th> <th>사용여부</th> <th>이벤트상태</th>
		</tr>
		<c:forEach items="${list}" var="coupon" varStatus="status">
			<tr>
					
				<td class="book_index">${total - ((paging.nowPage-1) * cnt + status.index)}</td>
				<%-- <td>${coupon.couponId}</td>
				<td>${coupon.event.eventNo}</td> --%>
				<td style="width:200px">${coupon.event.eventName}</td>
				<td style="width:200px;">${coupon.event.eventStart} ~ ${coupon.event.eventEnd}</td>
				<td style="width:50px">
					<c:if test="${coupon.usedYn == 'n'}">사용가능</c:if>
					<c:if test="${coupon.usedYn == 'y'}">사용완료</c:if>
					<c:if test="${coupon.usedYn == 'e'}">미사용만료</c:if>
				</td>
				<td style="width:50px">
				<c:if test="${coupon.event.eventStatus == 's'}">진행중</c:if>
				<c:if test="${coupon.event.eventStatus == 'e'}">종료</c:if>
			</tr>
		</c:forEach>
		</table>
	<div class="paging">
			<c:if test="${paging.startPage != 1}">
				<a href="guestBook.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}"><i class="xi-angle-left"></i></a>	
			</c:if>
			&nbsp;&nbsp;
			<c:forEach begin="${paging.startPage}" end="${paging.endPage }" var="p">
				<c:choose>
					<c:when test="${p == paging.nowPage }">
					${p}
					</c:when>
					<c:when test="${p != paging.nowPage }">
						<a href="guestBook.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}"><b style="margin:5px;">${p}</b></a>
					</c:when>
				</c:choose>
			</c:forEach>
			&nbsp;&nbsp;
			<c:if test="${paging.endPage != paging.lastPage }">
				<a href="guestBook.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}"><i class="xi-angle-right"></i></a>
			</c:if>	
	</div>
	</div>
</body>
<%@ include file="../footer.jsp" %>  