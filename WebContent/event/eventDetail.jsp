<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
 <%@ include file="../header.jsp" %>  
<body style="text-align: center;">
	<div style="width: 80%; margin: auto;">
		<h1>${findEvent.eventName }</h1>
		<br> ${findEvent.eventStart} ~ ${findEvent.eventEnd }
		<hr>
		<br> <img alt="" src="${findEvent.eventPic }"><br>
		<br> ${findEvent.eventContent }
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
<%@ include file="../footer.jsp" %>   