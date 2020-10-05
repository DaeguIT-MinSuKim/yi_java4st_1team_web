<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>  
<link rel="stylesheet" href="booking/booking.css">
<script>
	document.title += ' - 예약 정보 확인'
</script>
<div id="bookingInfo">
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
</div>
<%@ include file="../footer.jsp" %>  