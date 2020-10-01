<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 정보 확인</title>
</head>
<body>
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

</body>
</html>