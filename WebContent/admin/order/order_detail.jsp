<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/header.jsp"%>
<script>
$(function(){
	$(document).ready(function() {
		document.title += ' - 주문 등록';
		$("#hairkindbox[kindNo='4']").trigger("click");
	});
	
	// 로딩 다 끝났을 때
	window.onload = function() {
	};
});
</script>

		  <!-- Page Heading -->
<!--           <h1 class="h3 mb-2 text-gray-800 font-weight">주문 상세페이지</h1> -->

          <!-- card -->
          <div class="card shadow mb-4" style="max-width: 800px;">
            <div class="card-header py-2">
              <h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
                <div class="mt-2 pl-3 float-left">
               		주문 상세페이지
                </div>
                <div class="float-right">
                  <a href="orderList.do" class="btn btn-sm btn-primary" id="toList"><span class="text">목록</span></a>
                </div>			
              </h6>
            </div>
            <!-- card-body -->
            <div class="card-body p-5">
              <form>
              	<p class="h6 font-weight-bold text-primary">▶ 주문 정보</p>
              	<div class="spacing"></div>
              	
                <div class="form-group">
                	<div class="row">
		                <label class="col-3 col-form-label font-weight-bold">주문번호</label>
		                <label class="col-6 col-form-label">${order.ordersNo}</label>
					</div>
                	<div class="row">
		                <label class="col-3 col-form-label font-weight-bold">주문일시</label>
		                <label class="col-6 col-form-label">${order.ordersDateStr}</label>
					</div>
                	<div class="row">
		                <label class="col-3 col-form-label font-weight-bold">고객</label>
                  		<label class="col-6 col-form-label text-primary">${order.guest.guestName } (${order.guest.guestId})</label>
					</div>
                	<div class="row">
		                <label class="col-3 col-form-label font-weight-bold">연락처</label>
                  		<label class="col-6 col-form-label">${order.guest.guestPhone} </label>
					</div>
                	<div class="row">
		                <label class="col-sm-3 col-form-label font-weight-bold">담당 디자이너</label>
                 		<label class="col-6 col-form-label">${order.designer.deNickname }</label>
					</div>
                </div>

				<div class="spacing"></div>
				<hr>
				<div class="spacing"></div>
								
				<p class="h6 font-weight-bold text-primary">▶ 시술 내역</p>
				<div class="spacing"></div>
				
				<table class="table thead-light table-bordered text-center" id="addedHairList">
					<thead>
						<tr>
							<th>No</th>
							<th>시술</th>
							<th>단가</th>
							<th>횟수</th>
							<th>가격</th>
						</tr>
					</thead>
					<c:forEach var="od" items="${order.odList }" varStatus="status">
						<tr>
							<td>${status.index+1}</td>
							<td>${od.hair.hairName }</td>
							<td><fmt:formatNumber value="${od.odPrice }" pattern="#,###" />원</td>
							<td>x ${od.odQuantity }</td>
							<td><fmt:formatNumber value="${od.odPrice * od.odQuantity }" pattern="#,###" />원</td>
						</tr>
					</c:forEach>
                </table>

				<div class="spacing"></div>
                <hr>
             		<%-- ${order.usedCoupon } --%>

                <div class="row pr-1 mb-2">
                  <div class="col-6 text-right font-weight-bold">
                  	합계
                  </div>
                  <div class="col-6 text-right">
                    <span class="text-right m-auto" id="totalAmount"><fmt:formatNumber value="${order.ordersTotalPrice + order.discountAmount }" pattern="#,###" /></span>
                    	<span class="align-bottom">원</span>
                  </div>
                </div>
				
                <div class="row pr-1 mb-2">
                  <div class="col-6 text-right font-weight-bold">
                  	 할인 금액
                  </div>
                  <div class="col-6 text-right">
                    <span class="text-right m-auto text-danger" id="discountAmount"><fmt:formatNumber value="${order.discountAmount }" pattern="#,###" /></span>
                    	<span class="align-bottom">원</span>
                  </div>
                </div>

	            <div class="row text-right pr-1">
                	<span class="col-sm-6 text-right font-weight-bold m-auto">총 금액</span>
					<span class="col-sm-6">
                    <span class="h4 text-right m-auto text-primary" id="totalPrice"><fmt:formatNumber value="${order.ordersTotalPrice }" pattern="#,###" /></span>
                    	<span class="align-bottom">원</span>
                  	</span>
                </div>

                <hr>
                
              </form>
            </div>
            <!-- cardBody-->
            
            <!-- card-footer -->
          	<!--<div class="card-footer p-1">
            </div> -->
            <!-- card-footer -->
          </div>

<%@ include file="../include/footer.jsp"%>
