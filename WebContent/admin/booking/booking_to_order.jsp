<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<script src="booking/admin_order.js"></script>
<script>
$(function(){
	$(document).ready(function() {
		document.title += ' - 예약 목록';
		$("#hairkindbox[kindNo='4']").trigger("click");
	});
	
	// 로딩 다 끝났을 때
	window.onload = function() {
	};
});
</script>
<!-- GuestSearch Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="guestSearchModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="guestSearchModalLabel">고객 검색 및 예약건 선택</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<div class="form-group row">
						<div class="col-sm-2">
							<label for="guest-name" class="col-form-label font-weight-bold">고객</label>
						</div>
						<div class="col-sm-2 pr-0">
							<select class="form-control">
								<option>아이디</option>
								<option>이름</option>
								<option>연락처</option>
							</select>
						</div>
						<div class="col-sm-3 pr-0">
							<input type="text" class="form-control" id="searchInput" placeholder="">
						</div>
						<div class="col-auto">
							<a href="#" class="btn btn-primary btn-sm" name="guestSearchBtn">
								<span class="text">검색</span></a>
						</div>
					</div>
				</form>
				<table class="table table-bordered col-8">
					<thead>
						<tr>
							<td></td>
							<td>아이디</td>
							<td>이름</td>
							<td>휴대폰 번호</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td></td>
							<td>test</td>
							<td>테스트유저</td>
							<td>010-1234-5678</td>
						</tr>
						<tr class="table-primary">
							<td></td>
							<td>test</td>
							<td>테스트유저</td>
							<td>010-1234-5678</td>
						</tr>
						<tr>
							<td></td>
							<td>test</td>
							<td>테스트유저</td>
							<td>010-1234-5678</td>
						</tr>
					</tbody>
				</table>
				<div class="spacing"></div>
				<div class="divider"></div>
				<div class="spacing"></div>
				<h6 class="font-weight-bold">금일 예약건 조회</h6>
				<table class="table table-bordered table-hover text-center" id="todayBookingTable">
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
				<div class="spacing"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" id="modalConfirm" data-dismiss="modal">선택 완료</button>
			</div>
		</div>
	</div>
</div>

		  <!-- Page Heading -->
          <h1 class="h3 mb-2 text-gray-800 font-weight">등록 페이지</h1>
          <p class="mb-4">여기에 간단한 설명 추가해주세요. 이렇게 링크도 달아도 됩니다. <a target="_blank" href="https://datatables.net">링크</a></p>

          <!-- card -->
          <div class="card shadow mb-4" style="max-width: 800px;">
            <div class="card-header py-2">
              <h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
                <div class="mt-2 pl-3 float-left">
               		주문하기
                </div>
                <div class="float-right">
                  <a href="#" id="prevPage" class="btn btn-secondary btn-sm" style="margin-right: 10px;"><span class="text">이전</span></a>
                  <a href="#" id="nextPage" class="btn btn-secondary btn-sm" style="margin-right: 10px;"><span class="text">다음</span></a>
                  <a href="#" id="toList" class="btn btn-primary btn-sm" style="margin-right: 10px;"><span class="text">목록</span></a>
                </div>			
                <!-- <a href="#" class="btn btn-danger btn-sm" style="float: right;">
                  <span class="text">삭제</spa>
                </a>
                <a href="#" class="btn btn-info btn-sm" style="float: right;  margin-right: 10px;">
                  <span class="text">수정</span>
                </a> -->
              </h6>
            </div>
            <!-- card-body -->
            <div class="card-body p-5">
              <form>
              	<input type="hidden" name="guestId" value="">
              	<input type="hidden" name="bookNo" value="">
                <div class="form-group row">
                  <label for="inputEmail3" class="col-3 col-form-label font-weight-bold">고객</label>
                  <div class="col-5">
                    <input type="text" class="form-control" id="guestInput" placeholder="검색 후 선택해주세요."><br>
                    <div class="ml-4">
	                    <input type="checkbox" class="form-check-input" id="nonMemberCK" value="true">
	                    <label class="form-check-label" for="">비회원</label>
                    </div>
                  </div>
                  <div class="col-auto">
                    <a href="#" class="btn btn-primary btn-sm" name="guestSearchBtn" data-toggle="modal" data-target="#exampleModal">
                      <span class="text">검색</spa>
                    </a>
                    <a href="#" class="btn btn-secondary btn-sm" name="guestClearBtn" onclick="setClear()">
                      <span class="text">취소</spa>
                    </a>
                  </div>
                  <!-- <div class="w-100"></div>
                  <div class="col-md-5 offset-md-3">
                  	<div class="col ml-2">
	                  	<input type="checkbox" class="form-check-input" id="nonMemberCK" value="true">
	                    <label class="form-check-label" for="">비회원</label>
                    </div>
                  </div> -->
                </div>
                <div class="spacing"></div>
                <div class="form-group row">
                  <label for="inputPassword3" class="col-3 col-form-label font-weight-bold">예약건</label>
                  <div class="col-6 col-form-label" name="bookingDetail">
						예약 고객인 경우 검색창을 통해 해당 예약건을 선택해주세요.
                  </div>
                </div>

                <div class="col-sm divider"></div>

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

                <div class="col-sm divider"></div>
                <div class="spacing"></div>

                <h7 class="mb-3 font-weight-bold">시술 대분류</h7>
                <ul class="list-group list-group-horizontal-md" id="hairkindbox">
               		<c:forEach items="${hairKindList }" var="hk">
                  		<li class="list-group-item flex-fill text-center" role="button" id="hairkindbox"
                  		 kindNo="${hk.kindNo }">${hk.kindNo }. ${hk.kindName }</li>
					</c:forEach>
                </ul>

                <div class="spacing"></div>
                
                <h7 class="mt-3 mb-3 font-weight-bold">시술 소분류</h7>
                <ul class="list-group list-group-horizontal-md" id="hairbox">
                </ul>
                
                <div class="spacing bg"></div>

				<ul class="addedHairList list-group list-group-flush">
				</ul>
				
				<!-- <div class="col-sm-12 text-right totalPrice">
				</div> -->
				
				<div class="divider"></div>

	            <div class="row">
                	<div class="col-4">
                	</div>
                	<div class="row col-8">
                  		<div class="col-sm-4 col-form-label text-left pt-2">
                  			<span style="line-height: 2.2;">합계</span></div>
                  		<div class="col-sm-8 col-form-label text-right align-middle">
                  			<span class="totalPrice h4" name="totalPrice" totalPrice="">0</span><span class="align-bottom pl-2">원</span>
                  		</div>
                	</div>
                </div>

                <div class="divider"></div>
                
                
                <div class="form-group row">
                  <div class="col-sm" style="text-align: right;">
                    <button type="submit" class="btn btn-primary">등록</button>
                  </div>
                </div>
              </form>
            </div>
            <!-- cardBody-->
            <!-- card-footer -->
            <div class="card-footer p-1">
              <div class="row control-inline">
                <div class="col-12 text-right">
                  <!-- <a href="#" id="prevPage" class="btn btn-secondary btn-sm" style="margin-right: 10px;"><span class="text">이전</span></a>
                  <a href="#" id="nextPage" class="btn btn-secondary btn-sm" style="margin-right: 10px;"><span class="text">다음</span></a>
                  <a href="#" id="toList" class="btn btn-primary btn-sm" style="margin-right: 10px;"><span class="text">목록</span></a> -->
                  <a href="#" class="btn btn-danger btn-sm" ><span class="text">삭제</span></a>
				          <a href="#" class="btn btn-warning btn-sm" ><span class="text-gray-800">주문하기</span></a>
                </div>
              </div>
            </div>
            <!-- card-footer -->
          </div>

<%@ include file="../include/footer.jsp"%>
