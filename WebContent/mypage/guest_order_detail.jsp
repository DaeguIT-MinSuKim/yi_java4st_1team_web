<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ include file="../header.jsp" %>  
     <%@ include file="sub_menu.jsp" %>
<style>
.order a {background-color:white;  border-bottom:1px solid white;}
#book_detail {border:1px solid black;}
#book_detail {border:1px solid black;}
</style>
<body>
<form method="post" name="formm">
 
<div class="book_detail_wrapper">
<p class="tcenter" style="font-weight:bold">주문 정보</p>
<table class="book_detail_info">
	<tr style="border-top:1px solid #e4e4e4;">
		<td>주문 번호</td><td class="border-left-line">${list.ordersNo} 
		<input type="hidden" value="${list.ordersNo}" name="bookNo">
		</td>
		
	</tr>
	<tr>
		<td>주문 일시</td>
		<td class="border-left-line">
			<fmt:parseDate value="${list.ordersDate} " pattern="yyyy-MM-dd'T'HH:mm" var="date" type="both" />
			<fmt:formatDate value="${date}" pattern="yyyy-MM-dd HH:mm" />
		</td>
	</tr>
	<tr>
		<td>주문 고객</td><td class="border-left-line">${list.guest.guestName}</td>
	</tr>
	<tr>
		<td>연락처</td><td class="border-left-line">${list.guest.guestPhone}</td>
	</tr>
	<tr>
		<td>담당 디자이너</td>
		<td class="border-left-line">${list.designer.deNickname}</td>
	</tr>
</table>

<br><br>

<p class="tcenter" style="font-weight:bold">시술 정보</p>
<table class="book_hair_info">

	<tr style="text-align:center;">
		
		<td style="border-top:1px solid #e4e4e4;">시술 정보</td> 
		<td style="border-top:1px solid #e4e4e4; width:100px;">단가</td> 
		<td style="border-top:1px solid #e4e4e4; width:80px;">수량</td>
		<td style="border-top:1px solid #e4e4e4; width:80px;">가격</td>
		
	</tr>
	<c:forEach var="od" items="${list.odList}" varStatus="status">
	<tr>
		<td style="text-align:center;">${od.hair.hairName}</td>
		<td class="border-left-line tcenter"><fmt:formatNumber value="${od.odPrice}" pattern="#,###" /></td>
		<td class="border-left-line tcenter">x ${od.odQuantity }</td>
		<td class="border-right-line tcenter"><fmt:formatNumber value="${od.odPrice * od.odQuantity }" pattern="#,###" />원</td>
		
	</tr>
	</c:forEach>
	<tr style="text-align:right; border:none;">
		<td colspan="4">합계  <fmt:formatNumber value="${list.ordersTotalPrice + list.discountAmount }" pattern="#,###" />원</td>
	</tr>
	<tr style="text-align:right; ">
       <td colspan="4">할인 금액  <fmt:formatNumber value="${list.discountAmount }" pattern="#,###" />원</td>
    </tr>
	<tr style="text-align:right; font-weight:bold">
		<td colspan="4">총 금액  <fmt:formatNumber value="${list.ordersTotalPrice }" pattern="#,###" />원</td>
	</tr>
	
</table>
      
<br>
<div class="tcenter" style="margin-top:50px;">
	<input type="button" class="button" value="목록보기" onclick="location.href='guestOrder.do'">
</div>
</div>
</form>
</body>

<%@ include file="../footer.jsp" %>  