<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<script>
	document.title += ' - 예약 목록'
</script>
<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">목록 템플릿</h1>
<p class="mb-4">
	여기에 간단한 설명 추가해주세요. 이렇게 링크도 달아도 됩니다. <a target="_blank"
		href="https://datatables.net">링크</a>
</p>

<!-- DataTales Example -->
<div class="card shadow mb-4">
	<div class="card-header py-2">
		<h6 class="m-1 font-weight-bold text-primary" style="font-size: 1.3em">
			예약내역 상세보기
			<a href="#" class="btn btn-danger btn-sm" style="float: right;">
				<span class="text">삭제</span></a>
			<a href="#" class="btn btn-warning btn-sm" style="float: right; margin-right: 10px;">
				<span class="text-gray-800">주문하기</span></a>
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body">
		<ul>
			<li>${booking }</li>
			<li>${booking.bookNo }</li>
			<li>${booking.bookDateStr }</li>
			<li>${booking.guest.guestId } (${booking.guest.guestName })</li>
			<li>${booking.guest.guestPhone }</li>
			<li>
				<c:forEach var="bookingHair" items="${booking.hairList }">
					[${bookingHair.hair.hairNo}]${bookingHair.hair.hairName}(${bookingHair.hair.hairPrice }) * ${bookingHair.quantity}회
					= ${bookingHair.hair.hairPrice * bookingHair.quantity}<br>
				</c:forEach>
			</li>
			<li>디자이너 : ${booking.designer.deName }</li>
			<li>[${booking.bookStatus }]${booking.bookStatusStr }</li>
			<li>예약등록일: ${booking.bookRegDateStr }</li>
		</ul>

		
		
		
		
		
		
		
	</div>
	<!-- cardBody-->
</div>

<%@ include file="../include/footer.jsp"%>
