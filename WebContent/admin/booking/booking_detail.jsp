<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ include file="../include/header.jsp"%>
<script>
	document.title += ' - 예약 목록'
</script>
<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">목록 템플릿</h1>
<!-- DataTales Example -->
<div class="card shadow mb-4" style="width:700px">
	<div class="card-header py-2" style="padding: 0px;">
		<h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
            <div class="float-right">
                <a href="#" id="prevPage" class="btn btn-secondary btn-sm" style="margin-right: 10px;"><span class="text">이전</span></a>
                <a href="#" id="nextPage" class="btn btn-secondary btn-sm" style="margin-right: 10px;"><span class="text">다음</span></a>
                <a href="bookingList.do" id="toList" class="btn btn-primary btn-sm" style="margin-right: 10px;"><span class="text">목록</span></a>
            </div>			
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body">
		<p class="tcenter font-weight-bold">예약 정보 </p>
		<table class="book_detail_info">
			<tr style="border-top:1px solid #e4e4e4;">
				<th>예약 번호</th><td class="border-left-line">${booking.bookNo} 
				<input type="hidden" value="${booking.bookNo}" name="bookNo">
				</td>
				
			</tr>
			<tr>
				<th>예약자</th><td class="border-left-line">${booking.guest.guestName}(${booking.guest.guestId})</td>
			</tr>
			<tr>
				<th>연락처</th><td class="border-left-line">${booking.guest.guestPhone}</td>
			</tr>
			<tr>
				<th>예약 이용일시</th> 
				<td class="border-left-line text-primary">
					<%-- <fmt:parseDate value="${booking.bookDate}" pattern="yyyy-MM-dd'T'HH:mm" var="bookDate" type="both" />
					<fmt:formatDate value="${bookDate}" pattern="yyyy-MM-dd HH:mm" /> --%>
					${booking.bookDateStrKo }
				</td>
			</tr>
			<tr>
				<th>담당 디자이너</th>
				<td class="border-left-line">${booking.designer.deNickname}</td>
			</tr>
			<tr>
				<th>예약 상태</th><td class="border-left-line">${booking.bookStatusStr}</td>
			</tr>
			<tr>
				<th>예약등록일</th>
				<td class="border-left-line">
					<%-- <fmt:parseDate value="${booking.bookRegDate}" pattern="yyyy-MM-dd'T'HH:mm" var="bookReg" type="both" />
					<fmt:formatDate value="${bookReg}" pattern="yyyy-MM-dd HH:mm" /> --%>
					${booking.bookRegDateStrStd }
				</td>
			</tr>
		</table>
		
		<br><br>
		
		<p class="tcenter font-weight-bold">시술 정보</p>
		<table class="book_hair_info">

			<tr style="text-align:center; height: 24px;">
				<th style="border-top:1px solid #e4e4e4; width:250px;">시술 정보</td> 
				<th style="border-top:1px solid #e4e4e4; width:50px;">가격</td> 
				<th style="border-top:1px solid #e4e4e4; width:50px;">수량</td>
			</tr>
			<c:forEach var="hairs" items="${booking.hairList}" varStatus="status">
				<tr>	
					<td class="tcenter">${hairs.hair.hairName}</td>
					<td class="border-left-line tcenter"><fmt:formatNumber value="${hairs.hair.hairPrice}" pattern="#,###" /></td>
					<td class="border-left-line tcenter">${hairs.quantity}</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="3" class="tright">합계 : <b style="font-weight:bold"><fmt:formatNumber value="${price}" pattern="#,###" /> 원</b></td>
			</tr>
		</table>
		
		
		
		
	</div>
	<!-- cardBody-->
	<!-- card-footer -->
	<div class="card-footer">
		<div class="row control-inline">
			<div class="col-12 text-right">
				<!-- <a href="#" id="prevPage" class="btn btn-secondary btn-sm" style="margin-right: 10px;"><span class="text">이전</span></a>
				<a href="#" id="nextPage" class="btn btn-secondary btn-sm" style="margin-right: 10px;"><span class="text">다음</span></a>
				<a href="#" id="toList" class="btn btn-primary btn-sm" style="margin-right: 10px;"><span class="text">목록</span></a> -->
				<a href="#" id="delete" class="btn btn-danger btn-sm deleteButton" style="margin-right: 10px;"><span class="text">삭제</span></a>
	          	<a href="bookingToOrder.do?no=${booking.bookNo}" id="bookingToOrder" class="btn btn-warning btn-sm bookingToOrder" ><span class="text-gray-800">주문하기</span></a>
			</div>
		</div>
	</div>
	<!-- card-footer -->
</div>




<%@ include file="../include/footer.jsp"%>
