<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>evnetDetail</title>
</head>
<body style="text-align: center;">
	<div style="width: 80%; margin: auto;">
		<hr>
		<h1>${event.eventName }</h1><br>
		${event.eventStart} ~ ${event.eventEnd }
		<hr><br>
		<img alt="" src="${event.eventPic }"><br><br>
		${event.eventContent }
	</div>
</body>
</html>