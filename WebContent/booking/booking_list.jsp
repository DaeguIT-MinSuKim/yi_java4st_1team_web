<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="booking.css">
<script>
	document.title += ' - 예약 내역'
</script>
<table>
	<tr>
		<th>예약 번호</th>
		<th>예약일시</th>
		<th>고객명</th>
		<th>예약상태</th>
	</tr>
	<c:forEach var="booking" items="${bookingList }">
		<tr>
			<td><a href="bookingDetail.do?no=${booking.bookNo }">${booking.bookNo }</a></td>
			<td>${booking.bookDate }</td>
			<td>${booking.guest.guestName }</td>
			<td>${booking.bookStatusStr }</td>
		</tr>
	</c:forEach>
</table>
<a href="booking.do">예약하기</a>
<%@ include file="../footer.jsp" %>  