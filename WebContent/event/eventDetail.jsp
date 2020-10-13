<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>evnetDetail</title>
</head>
<body style="text-align: center;">
	<div style="width: 80%; margin: auto;">
		<hr>
		<h1>${event.eventName }</h1>
		<br> ${event.eventStart} ~ ${event.eventEnd }
		<hr>
		<br> <img alt="" src="${event.eventPic }"><br>
		<br> ${event.eventContent }
	</div>
	
	<br><br><br><br>
	<div style="display: block; text-align: center;">
		<c:forEach items="${list }" var="event">
			<ul>
				<li><a href="eventDetail.do?eno=${event.eventNo }">
						<div>
							<p>
								<span>${event.eventName }</span>
						</div></a></li>
			</ul>
		</c:forEach>
	</div>
</body>
</html>