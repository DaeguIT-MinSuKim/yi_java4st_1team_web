<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
  <%@ include file="../header.jsp" %>  

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
<%@ include file="../footer.jsp" %>   