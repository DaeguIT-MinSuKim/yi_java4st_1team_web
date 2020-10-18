<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../header.jsp" %>  
<link rel="stylesheet" href="booking/booking.css">
<script>
	document.title += ' - 예약 정보 확인'
</script>
<div id="bookingInfo">
<ul>
	<li>${booking.bookNo }</li>
	<li>${booking.guest.guestName }(${booking.guest.guestId })</li>
	<li>${booking.bookDateStr }</li>
	<li>
		<ul>
			<c:forEach var="h" items="${booking.hairList }">
				<li>[${h.hair.hairNo }] ${h.hair.hairName } : ${h.quantity }</li>
			</c:forEach>
		</ul>
	</li>
	<li>${booking.designer.deName }</li>
	<li>${booking.bookRegDateStr }</li>
	<li>[${booking.bookStatus }] ${booking.bookStatusStr }</li>
	<li>${booking.bookNote }</li>
</ul>
</div>
<%@ include file="../footer.jsp" %>  