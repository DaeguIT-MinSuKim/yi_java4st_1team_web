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
<p style="text-align:center; font-size:30px;">쿠폰 내역</p>
<table id="board">
		<tr>
			 <th>번호</th> <!-- <th>(확인용)쿠폰번호</th><th>이벤트번호</th> --> <th>쿠폰이름</th> <th>쿠폰 기간(시작~종료)</th> <th>쿠폰사용여부</th> <th>이벤트종료유무</th>
		</tr>
		<c:forEach items="${list}" var="coupon" varStatus="status">
			<tr onclick="location.href='guestBookDetail.do'" style="cursor:pointer;" class="mypage_title">
					
				<td>${total - ((paging.nowPage-1) * cnt + status.index)}</td>
				<%-- <td>${coupon.couponId}</td>
				<td>${coupon.event.eventNo}</td> --%>
				<td>${coupon.event.eventName}</td>
				<td>${coupon.event.eventStart} ~ ${coupon.event.eventEnd}</td>
				<td>${coupon.usedYn}</td>
				<td>${coupon.event.eventUseYn}
				<%-- <fmt:parseDate value="${booking.bookDate}" pattern="yyyy-MM-dd'T'HH:mm" var="bookDate" type="both" />
					<fmt:formatDate value="${bookDate}" pattern="yyyy-MM-dd HH:mm" /> --%>
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