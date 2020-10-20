<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ include file="../header.jsp" %>  
     <%@ include file="sub_menu.jsp" %>
<style>
.book a {background-color:white;  border-bottom:1px solid white;}
#book_detail {border:1px solid black;}
#book_detail {border:1px solid black;}
</style>
<body>
<div class="book_detail_wrapper">
<br>

<p>예약 정보</p>
<table class="book_detail_info">
	<tr>
		<td>예약 번호</td><td>${booking.bookNo}</td>
	</tr>
	<tr>
		<td>예약자</td><td>${booking.guest.guestName}</td>
	</tr>
	<tr>
		<td>예약 상태</td><td>${booking.bookStatus}</td>
	</tr>
	<tr>
		
	</tr>
</table>
<br><br>
<p>시술 정보</p>
<table class="book_hair_info">

	<tr>
		<th>시술 정보</th> <th>수량</th>
	</tr>
	<c:forEach var="hairs" items="${booking.hairList}" varStatus="status">
	<tr>	
		<td style="text-align:center;">${hairs.hair.hairName}</td><td style="text-align:center;">${hairs.quantity}<td>
	</tr>
	</c:forEach>		

</table>
<%-- <table class="book_detail_info">
	<tr>
		<td>예약 번호</td><td>${bookNo}</td>
	</tr>
	<tr>
		<td>예약자</td><td>${guest}</td>
	</tr>
	<tr>
		<td>예약 상태</td><td>${status}</td>
	</tr>
	<tr>
		
	</tr>
</table>
<br><br>
<p>시술 정보</p>
<table class="book_hair_info">

	<tr>
		<th>시술 정보</th> <th>수량</th>
	</tr>
	<c:forEach var="hairs" items="${hairList}" varStatus="status">
	<tr>	
		<td style="text-align:center;">${hairs.hair.hairName}</td><td style="text-align:center;">${hairs.quantity}<td>
	</tr>
	</c:forEach>		

</table> --%>
<br>
<div class="div_price">
<p>총 결제 금액 : ${price}</p>
</div>
<div class="book_detail_bottons">
	<input type="button" class="button" value="예약 취소">
</div>

</div>
</body>

<%@ include file="../footer.jsp" %>  