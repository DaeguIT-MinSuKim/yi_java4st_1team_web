<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ include file="../header.jsp" %>  
     <%@ include file="sub_menu.jsp" %>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<style>
.book a {color: black; padding:30px 60px; border: 1px solid #ddd; border-top: 2px solid gray; border-bottom: 1px solid #ffffff;}
</style>     
<body>
<div class="book_wrapper">
<p style="text-align:center; font-size:30px;">예약 내역</p>
<table id="board">
<tr>
	<th>번호</th> <th>예약일</th> <th>시술명</th> <th>총 금액</th> <th>예약상태</th> <th>예약등록일</th> <th>상세내역</th>
</tr>
<c:forEach items="${bookList}" var="booking" varStatus="status">
<tr>
	<!-- 일단 카운트만  -->
	<td>${status.count}</td>
	<td>
		<fmt:parseDate value="${booking.bookDate}" pattern="yyyy-MM-dd'T'HH:mm" var="bookDate" type="both" />
		<fmt:formatDate value="${bookDate}" pattern="yyyy-MM-dd HH:mm" />
	</td>
	<td>${booking.hair.hairName}</td>
	<td>${booking.hair.hairPrice}</td>
	<td>${booking.bookStatus}</td>
	<td>
		<fmt:parseDate value="${booking.bookRegDate}" pattern="yyyy-MM-dd'T'HH:mm" var="bookReg" type="both" />
		<fmt:formatDate value="${bookReg}" pattern="yyyy-MM-dd" />
	</td>
	<td>버튼넣기</td>
</tr>
</c:forEach>
</table>
</div>
</body>


<%@ include file="../footer.jsp" %>  