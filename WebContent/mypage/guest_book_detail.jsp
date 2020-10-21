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
<form method="post" name="formm" action="guestBookCandel.do">

<div class="book_detail_wrapper">
<p>예약 정보</p>
<table class="book_detail_info">
	<tr style="border-top:1px solid #e4e4e4;">
		<td>예약 번호</td><td class="border-left-line">${booking.bookNo} 
		<input type="hidden" value="${booking.bookNo}" name="bookNo">
		</td>
		
	</tr>
	<tr>
		<td>예약일</td>
		<td class="border-left-line">
			<fmt:parseDate value="${booking.bookRegDate}" pattern="yyyy-MM-dd'T'HH:mm" var="bookReg" type="both" />
			<fmt:formatDate value="${bookReg}" pattern="yyyy-MM-dd HH:mm" />
		</td>
	</tr>
	<tr>
		<td>예약자</td><td class="border-left-line">${booking.guest.guestName}</td>
	</tr>
	<tr>
		<td>예약 상태</td><td class="border-left-line">${booking.bookStatusStr}</td>
	</tr>
	<tr>
		<td>이용 날짜</td> 
		<td class="border-left-line">
			<fmt:parseDate value="${booking.bookDate}" pattern="yyyy-MM-dd'T'HH:mm" var="bookDate" type="both" />
			<fmt:formatDate value="${bookDate}" pattern="yyyy-MM-dd HH:mm" />
		</td>
	</tr>
	<tr>
		<td>담당 디자이너</td>
		<td class="border-left-line">${booking.designer.deName}</td>
	</tr>
</table>

<br><br>

<p>시술 정보</p>
<table class="book_hair_info">

	<tr style="text-align:center;">
		<td style="border-top:1px solid #e4e4e4;">시술 정보</td> 
		<td style="border-top:1px solid #e4e4e4; width:100px;">가격</td> 
		<td style="border-top:1px solid #e4e4e4; width:80px;">수량</td>
	</tr>
	<c:forEach var="hairs" items="${booking.hairList}" varStatus="status">
	<tr>	
		<td style="text-align:center;">${hairs.hair.hairName}</td>
		<td class="border-left-line tcenter"><fmt:formatNumber value="${hairs.hair.hairPrice}" pattern="#,###" /></td>
		<td class="border-left-line tcenter">${hairs.quantity}</td>
	</tr>
	</c:forEach>
	<tr>
		<td colspan="3" class="tright">합계 : <b style="font-weight:bold"><fmt:formatNumber value="${price}" pattern="#,###" /> 원</b></td>
	</tr>
</table>
<br>
<div class="tcenter" style="margin-top:50px;">
	<input type="button" class="button" value="목록보기" onclick="location.href='guestBook.do'">
	<input type="button" class="button" value="예약취소" onClick="book_cancel()">
</div>
</div>
</form>
</body>

<%@ include file="../footer.jsp" %>  