<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ include file="../header.jsp" %>  
     <%@ include file="sub_menu.jsp" %>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
         
<style>
.book a {color: black; padding:30px 60px; border: 1px solid #ddd; border-top: 2px solid gray; border-bottom: 1px solid #ffffff;}
</style>     
<body>
<p>예약 내역</p>
<table>
<tr>
	<th>번호</th> <th>예약일</th> <th>시술명</th> <th>가격</th> <th>예약상태</th> <th>예약등록일</th>
</tr>
<c:forEach items="${bookList}" var="booking">
<tr>
	<td>카운트</td>
	<td>${booking.bookRegDate}</td>
	<td>${booking.hair.hairName}</td>
	<td>${booking.hair.hairPrice}</td>
	<td>${booking.bookStatus}</td>
	<td>${booking.bookDate }</td>
</tr>
</c:forEach>
</table>
<c:forEach items="${bookList}" var="booking">
	<ul>
		<li>${booking.bookNo }</li>
		<li>${booking.guest.guestName }(${booking.guest.guestId })</li>
		<li>${booking.bookDate }</li>
		<li>${booking.hair.hairName }</li>
		<li>${booking.designer.deName }</li>
		<li>${booking.bookRegDate }</li>
		<li>${booking.bookStatus }</li>
		<li>${booking.bookNote }</li>
	</ul>
</c:forEach>
</body>


<%@ include file="../footer.jsp" %>  