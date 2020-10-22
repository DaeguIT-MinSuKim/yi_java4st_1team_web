<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<script>
	document.title += ' - 예약 목록'
</script>
<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">주문 관리</h1>
<p class="mb-4">
	여기에 간단한 설명 추가해주세요. 이렇게 링크도 달아도 됩니다. <a target="_blank" href="https://datatables.net">링크</a>
</p>

<!-- DataTales Example -->
<div class="card shadow mb-4">
	<div class="card-header py-2" style="padding: 0px;">
		<h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
			<div class="mt-2 float-left pl-3">
             	주문하기
            </div>
            <div class="float-right">
                <!-- <a href="#" id="prevPage" class="btn btn-secondary btn-sm" style="margin-right: 10px;"><span class="text">이전</span></a>
                <a href="#" id="nextPage" class="btn btn-secondary btn-sm" style="margin-right: 10px;"><span class="text">다음</span></a> -->
                <a href="#" id="toList" class="btn btn-primary btn-sm" style="margin-right: 10px;"><span class="text">목록</span></a>
            </div>			
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
	<!-- card-footer -->
	<div class="card-footer">
		<div class="row control-inline">
			<div class="col-12 text-right">
				<!-- <a href="#" id="prevPage" class="btn btn-secondary btn-sm" style="margin-right: 10px;"><span class="text">이전</span></a>
				<a href="#" id="nextPage" class="btn btn-secondary btn-sm" style="margin-right: 10px;"><span class="text">다음</span></a>
				<a href="#" id="toList" class="btn btn-primary btn-sm" style="margin-right: 10px;"><span class="text">목록</span></a> -->
				<a href="#" id="delete" class="btn btn-danger btn-sm deleteButton" style="margin-right: 10px;"><span class="text">삭제</span></a>
	          	<a href="#" id="bookingToOrder" class="btn btn-warning btn-sm bookingToOrder" ><span class="text-gray-800">주문하기</span></a>
			</div>
		</div>
	</div>
	<!-- card-footer -->
</div>

<%@ include file="../include/footer.jsp"%>
