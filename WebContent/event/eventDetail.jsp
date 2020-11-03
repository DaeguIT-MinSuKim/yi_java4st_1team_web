<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
 <%@ include file="../header.jsp" %> 
<style>
.btn {color:black; font-size:15px; background: white; border:1px solid #777;}
</style> 
<body style="text-align: center;">
	<div style="width: 80%; margin: auto;">
		<h1>${findEvent.eventName }</h1>
		<br> ${findEvent.eventStart} ~ 
			<c:if test="${findEvent.eventEnd == '9999-12-30'}">상시적용</c:if>
   			<c:if test="${findEvent.eventEnd != '9999-12-30'}">${event.eventEnd}</c:if>
		<hr>
		<br> <img alt="" src="event/images/${findEvent.eventPic}" width=80%><br>
		<br> ${findEvent.eventContent }
	</div>

	<div style="padding-top:80px;">
		<input type="button" value="목록" class="btn" onclick="location.href='eventHome.do' ">
	</div>
</body>
<%@ include file="../footer.jsp" %>   