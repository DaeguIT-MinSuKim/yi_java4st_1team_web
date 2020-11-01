<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<script src="order/admin_order.js"></script>
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
<!-- GuestSearch Modal -->
<div class="modal fade" id="guestSearchModal" tabindex="-1" aria-labelledby="guestSearchModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title font-weight-bold" id="guestSearchModalLabel">고객 검색</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<div class="form-group row">
						<div class="col-sm-3 pr-0">
							<select class="form-control" id="guestSearchOpt">
								<option value="0">전체</option>
								<option value="1">아이디</option>
								<option value="2">이름</option>
								<option value="3">연락처</option>
							</select>
						</div>
						<div class="col-sm-7 pr-0">
							<input type="text" class="form-control" id="guestSearchInput" placeholder="">
						</div>
						<div class="col-auto">
							<a href="#" class="btn btn-primary btn-sm" name="guestSearchBtn" id="guestSearchBtn">
								<span class="text">검색</span></a>
						</div>
					</div>
				</form>
				<table class="table table-bordered table-hover text-center" id="guestSearchTable">
					<thead>
						<tr>
							<td></td>
							<td>아이디</td>
							<td>이름</td>
							<td>휴대폰 번호</td>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				<div class="row text-center">
					<div class="paging_simple_numbers m-auto" id="guestSearchTable_paginate">
						<ul class="pagination pagination-sm">
						</ul>
					</div>
				</div> 
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-sm btn-primary" id="guestSearchModalConfirm" data-dismiss="modal">선택 완료</button>
			</div>
		</div>
	</div>
</div>

<!-- BookingSearch Modal -->
<div class="modal fade" id="bookingSearchModal" tabindex="-1" aria-labelledby="bookingSearchModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title font-weight-bold" id="bookingSearchModalLabel">금일 예약건 선택</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<table class="table table-bordered table-hover text-center mt-3" id="todayBookingTable">
					<thead>
						<tr>
							<td>예약번호</td>
							<td>예약일</td>
							<td>아이디</td>
							<td>이름</td>
							<td>시술</td>
							<td>디자이너</td>
							<td>연락처</td>
						</tr>
					</thead>
					<tbody>
						<c:if test="${todayBookingList eq null }">
							<td colspan="7">오늘 방문 예정인 예약건이 없습니다.</td>
						</c:if>
						<c:forEach var="todayB" items="${todayBookingList }">
							<tr role="button">
								<td>${todayB.bookNo }</td>
								<td>${todayB.bookDateStr }</td>
								<td>${todayB.guest.guestId }</td>
								<td>${todayB.guest.guestName } </td>
								<td>${todayB.howManyHairItems }</td>
								<td>${todayB.designer.deNo }</td>
								<td>${todayB.guest.guestPhone }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-sm btn-primary" id="bookingSearchModalConfirm" data-dismiss="modal">선택 완료</button>
			</div>
		</div>
	</div>
</div>

		  <!-- Page Heading -->
          <h1 class="h3 mb-2 text-gray-800 font-weight">주문 등록</h1>

          <!-- card -->
          <div class="card shadow mb-4" style="max-width: 800px;">
            <div class="card-header py-2">
              <h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
                <div class="mt-2 pl-3 float-left">
               		주문하기
                </div>
                <div class="float-right">
                  <button class="btn btn-sm btn-secondary" name="clearBtn" onclick="setClear()">초기화</button>
                  <a href="orderList.do" class="btn btn-sm btn-primary" id="toList"><span class="text">목록</span></a>
                </div>			
              </h6>
            </div>
            <!-- card-body -->
            <div class="card-body p-5">
              <form>
              	<input type="hidden" name="guestId" value="">
              	<input type="hidden" name="bookNo" value="">
                <div class="form-group row">
                  <label for="inputEmail3" class="col-3 col-form-label font-weight-bold">고객</label>
                  <div class="col-6">
                    <input type="text" class="form-control" id="guestInput" placeholder="검색 후 선택해주세요."><br>
                    <div class="ml-4">
	                    <input type="checkbox" class="form-check-input" id="nonMemberCK" value="true">
	                    <label class="form-check-label" for="">비회원</label>
                    </div>
                  </div>
                  <div class="col-auto">
                    <button type="button" class="btn btn-primary btn-sm" name="guestSearchBtn" id="guestSerachModalOpenBtn" data-toggle="modal" data-target="#guestSearchModal">검색</button>
                    
                  </div>
                </div>
                <div class="spacing"></div>
                <div class="form-group row">
                  <label for="inputPassword3" class="col-3 col-form-label font-weight-bold">예약건</label>
                  <div class="col-6 col-form-label" name="bookingDetail">
						예약 고객인 경우 검색창을 통해 해당 예약건을 선택해주세요.
                  </div>
                  <div class="col-auto">
                    <button type="button" class="btn btn-primary btn-sm" name="bookingSearchBtn" id="bookingSerchModalOpenBtn" data-toggle="modal" data-target="#bookingSearchModal">검색</button>
                  </div>
                </div>

                <hr>

                <div class="form-gruop row">
                  <label for="designerSelector" class="col-sm-3 col-form-label font-weight-bold">디자이너</label>
                    <div class="col-sm-5">
                      <select class="form-control" id="designerSelector">
                        <option value="">- 디자이너 선택 -</option>
                        <c:forEach items="${deList }" var="de">
                        	<option value="${de.deNo }">${de.deName} ${de.deLevel }</option>
                        </c:forEach>
                      </select>
                    </div>
                    
                </div>

                <hr>

                <p class="h7 font-weight-bold">시술 대분류</p>
                <ul class="list-group list-group-horizontal-md" id="hairkindbox">
               		<c:forEach items="${hairKindList }" var="hk">
                  		<li class="list-group-item flex-fill text-center" role="button" id="hairkindbox" kindNo="${hk.kindNo }">
                  		${hk.kindNo }. ${hk.kindName }</li>
					</c:forEach>
                </ul>

                <div class="spacing m-2"></div>
                
                <p class="h7 font-weight-bold">시술 소분류</p>
                <ul class="list-group list-group-horizontal-md" id="hairbox">
                </ul>
                
                <div class="spacing"></div>
                <hr>

				<table class="table table-borderless text-right addedHairList" id="addedHairList">
                </table>

                <hr>
                <div class="row mb-3 pr-1">
                  <div class="col-4"></div>
                  <div class="col-2 m-auto font-weight-bold">사용가능 쿠폰</div>
                  <div class="col-3">
                    <select class="form-control" id="couponBox" disabled>
                    </select>
                  </div>
                  <div class="col-3">
                    <select class="form-control" id="couponTargetBox" disabled>
                    </select>
                  </div>
                </div>

				<hr>

                <div class="row pr-1 mb-2">
                  <div class="col-6 text-right font-weight-bold">
                  	합계
                  </div>
                  <div class="col-6 text-right">
                    <span class="text-right m-auto" id="totalAmount" totalAmount="">0</span>
                    	<span class="align-bottom">원</span>
                  </div>
                </div>
				
                <div class="row pr-1 mb-2">
                  <div class="col-6 text-right font-weight-bold">
                  	 할인 금액
                  </div>
                  <div class="col-6 text-right">
                    <span class="text-right m-auto" id="discountAmount" discountAmount="">0</span>
                    	<span class="align-bottom">원</span>
                  </div>
                </div>

	            <div class="row text-right pr-1">
                	<span class="col-sm-6 text-right font-weight-bold m-auto">총 금액</span>
					<span class="col-sm-6">
                    <span class="h4 text-right m-auto" id="totalPrice" name="totalPrice" totalPrice="">0</span>
                    	<span class="align-bottom">원</span>
                  	</span>
                </div>

                <hr>
				<div class="spacing bg"></div>
                
                <div class="form-group row">
                  <div class="col-sm" style="text-align: right;">
                 	<button type="button" class="btn btn-secondary" name="clearBtn" onclick="setClear()">초기화</button>
                    <button type="button" class="btn btn-primary" id="orderRegBtn">등록</button>
                  </div>
                </div>
              </form>
            </div>
            <!-- cardBody-->
            <!-- card-footer -->
          	<!--<div class="card-footer p-1">
            </div> -->
            <!-- card-footer -->
          </div>

<%@ include file="../include/footer.jsp"%>
