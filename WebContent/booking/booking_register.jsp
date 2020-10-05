<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>  
<script>
	document.title += ' - 예약하기'
</script>
<div class="content">
<form>
	<ul>
		<li><label for="bookName">예약자 : </label>
		<input type="text" name="bookName" readOnly></li>
		<li><label for="bookDate">예약일 : </label>
		<input type="date" name="bookDate"></li>
		<li><label for="bookTime">예약시간: </label>
		<input type="time" name="bookTime" min="10:00" max="21:00" step="1200" required></li>
	</ul>
	
</form>
</div>
<%@ include file="../footer.jsp" %>  