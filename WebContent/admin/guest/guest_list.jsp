<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<script>
document.title += ' - 고객 목록';
	
function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href="guestList.do?nowPage=1&cntPerPage="+sel+"&del=${del}&where=${where}&query=${query}";
};

function selectAll(){
	$('[name=check]').prop('checked', true);
};

function deselectAll(){
	$('[name=check]').prop('checked', false);
};


$(document).on('click', '[name=delete]', function() { 
	/* $("#dataTable tr:nth-child(2)").css("background", "red"); */
	 var array = new Array();
    $("#dataTable input[name=check]:checked").each(function() {
    	array.push(this.value);
    });
    console.log(array);
    
    if(array==0){
    	alert('삭제할 회원을 선택하세요');
    	return;
    }
    
   //셀렉트박스 선택한 사람 배열로 ajax로 넘기기
    if(confirm(array + "님을 탈퇴처리 하시겠습니까?") == true){
	    $.ajax({
	  		  type:'post',
	  		  url:'guestDelete.do',
	  		  data:{"string":array},
	  		  async: false,
	  		  success:function(JSON){
	  			  /* alert("성공"); */
	  			  location.reload();
	  		  },
	  		  error:function(){
	  			  alert('삭제할 회원을 선택하세요');
	  		  }
	     	});
    }else {
    	return;
    }
  
    //대현
    /* var delArr = {};
    for(var i=0; i < $("#dataTable input[name=check]:checked").length; i++ ){
  		delArr[i] += $("#dataTable input[name=check]:checked").eq(i).val();
    }
   	
    console.log(delArr);  */
});

$(document).on('click', '[id=btn_delete]', function() { 
	var guest = $(this).attr('guestId');
	if(confirm(guest + '님을 탈퇴처리 하시겠습니까?') == true) {
		location.href="guestDelete.do?id="+guest;	
	}else {
		return;
	}

});



$("#searchBtn").click(function(e) {
	if($("select[name=where]").val() == undefined || $("input[name=query]").val() == "") {
		e.preventDefault();
	}
});

console.log($("select[name=where]").val());	

$("#where").change(function(){
	$("select[name=where]").val()
})



</script>

<!-- Page Heading -->
<form name="formm">
<!-- DataTales Example -->
<div class="card shadow mb-4">
	<div class="card-header py-2">
			<div class="mt-1 float-left">
				<h6 class="m-1 font-weight-bold text-primary" style="font-size: 1.3em">고객 관리</h6>
			</div>
			
	
				<button type="button" onclick="deselectAll()" class="btn btn-outline-secondary btn-sm" style="float: right;  margin-right: 10px;">
					선택해제
				</button>
				<button type="button" onclick="selectAll()" class="btn btn-secondary btn-sm" style="float: right;  margin-right: 10px;">
					전체선택
				</button>
				<input type="button"  value="선택삭제" name="delete" class="btn btn-danger btn-sm" style="float: right; margin-right: 10px;" >
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body">
		<div class="table-responsive">
			<!-- bootStrap table wrapper-->
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">

				<!-- 테이블 상단 필터링 시작 -->
				<div class="row mb-2">
					<div class="col-sm-12 col-md-6">
						<div class="dataTables_length" id="dataTable_length" style="float:left">
							<label>
							<select name="dataTable_length" id="cntPerPage" onchange="selChange()" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm">
									<option value="5" <c:if test="${paging.cntPerPage == 5}">selected</c:if>>5줄 보기</option>
							<option value="10"
								<c:if test="${paging.cntPerPage == 10}">selected</c:if>>10줄 보기</option>
							<option value="15"
								<c:if test="${paging.cntPerPage == 15}">selected</c:if>>15줄 보기</option>
							<option value="20"
								<c:if test="${paging.cntPerPage == 20}">selected</c:if>>20줄 보기</option>
							</select>
							</label>
							
						
						</div>
					</div>
					<div class="col-sm-12 col-md-6">
						<div id="dataTable_filter" class="dataTables_filter ">
							<select class="custom-select custom-select-sm" id="where" name="where" style="width: 80px;">
								<option value="0">기준</option>
								<option value="guestId">아이디</option>
								<option value="guestName">고객명</option>
								<option value="guestPhone">폰번호</option>
							</select>
							<label>
								<input type="hidden" name="del" value="${del}">
								<input type="search" name="query" class="form-control form-control-sm" placeholder="" aria-controls="dataTable">
							</label>
							<input type="submit" value="검색" class="btn btn-primary btn-sm" id="searchBtn" ></input>
						</div>
					</div>
				</div>
				<!-- 테이블 상단 필터링 끝 -->

				<!-- 테이블 시작 -->
				<table class="table table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
					<thead>
						<tr>
							<th></th>
							<th></th>
							<th>아이디</th>
							<th>고객명</th>
							<th>생년월일</th>
							<th>연락처</th>
							<th>이메일</th>
							<th>성별</th>
							
							<th>주문 전환</th>
							<th>상세보기</th>
							<th>고객 정보</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="guest" items="${list}" varStatus="status">
						<tr>
							<td><input type="checkbox" name="check" value="${guest.guestId}"></td>
							<td style="width:20px;"> ${total - ((paging.nowPage-1) * cnt + status.index)}</td>
							<td style="width:80px;">${guest.guestId}</td>
							<td style="width:80px;">${guest.guestName }</td>
							<td style="width:130px;">${guest.guestBirthday}</td>
							<td style="width:150px;">${guest.guestPhone}</td>
							<td style="width:150px;">${guest.guestEmail}</td>
							<td style="width:50px;">
							<a href="deleteGuest.do?id=${guest.guestId}"></a>
							<c:if test="${guest.guestGender == 0}">여</c:if>
							<c:if test="${guest.guestGender == 1}">남</c:if>
							</td>
							
							<td style="width:100px;">
								<a href="orderForm.do?guestId=${guest.guestId }" class="btn bg-warning btn-sm bookingToOrderButton"><span class="text-gray-800">주문</span></a>
							</td>
							<td  style="width:200px;">
								<input type="button" name="booking" value="예약내역" class="btn bg-gray-200 btn-sm detailViewButton" onclick="location.href='bookingList.do?where=guestId&query=${guest.guestId}'">
								<input type="button" name="order" value="주문내역" class="btn bg-gray-200 btn-sm detailViewButton" onclick="location.href='bookingList.do?where=guestId&query=${guest.guestId}'">
								<input type="button" name="guest" value="회원정보" class="btn bg-gray-200 btn-sm detailViewButton" onclick="location.href='guestData.do?id=${guest.guestId}' ">
							</td>
							<td  style="width:100px;">
								<input type="button" name="update" value="수정" class="btn btn-primary btn-sm" onclick="location.href='guestInfo.do?id=${guest.guestId}'">
								<input type="button" value="삭제" id="btn_delete" guestId="${guest.guestId}" class="btn btn-primary btn-sm">
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- 테이블 끝 -->
				<input type="button" value="등록" class="btn btn-info btn-sm" style="float: left;  margin-right: 10px;" onclick="location.href='guestAdd.do' ">
				<input type="button"  value="선택삭제" name="delete" class="btn btn-secondary btn-sm" style="float: left; margin-right: 10px;" >
				
				<input type="button" value="탈퇴고객" name="delGuest" class="btn btn-dark btn-sm" onclick="location.href='guestList.do?nowPage=1&del=y&where=${where}&query=${query}'" style="float:right; margin-left: 20px;">
			
	
					<!-- 페이징 시작 -->

					<div style="width:100%; text-align:center; display:inline-block; margin:0 auto;">
					<p>Total : ${total}</p>
					
						<!-- << -->
						<c:if test="${paging.startPage != 1}">
							<div class="paging-line">
							<a href="guestList.do?nowPage=${paging.startPage -1}&del=${del}&where=${where}&query=${query}">
								<i class="fas fa-angle-double-left"></i>
							</a>
							</div>
						</c:if>
						<c:if test="${paging.startPage == 1}">
							<div class="paging-line">
								<i class="fas fa-angle-double-left"></i>
							</div>
						</c:if>
						
						
						<!-- 이전페이지 -->
						<c:choose>
							<c:when test="${paging.nowPage != 1}">
								<div class="paging-line">
									<a href="guestList.do?nowPage=${paging.nowPage-1}&del=${del}&where=${where}&query=${query}"><i class="fas fa-angle-left"></i></a>
								</div>
							</c:when>
							<c:when test="${paging.nowPage == 1}">
								<div class="paging-line">
									<i class="fas fa-angle-left"></i>
								</div>
							</c:when>
						
						</c:choose>
						
						<!-- 페이지 숫자 -->
						
						<c:forEach begin="${paging.startPage}" end="${paging.endPage }"
							var="p">
							<c:choose>
								<c:when test="${p == paging.nowPage }">
									<div class="paging-line" style="font-weight:bold">${p}</div>
								</c:when>
								<c:when test="${p != paging.nowPage }">
									<div class="paging-line">
									<a href="guestList.do?nowPage=${p}&del=${del}&where=${where}&query=${query}">
									${p}</a></div>
								</c:when>
							</c:choose>
						</c:forEach>
						
						
						
						<!-- 다음페이지 -->
						<c:choose>
							<c:when test="${paging.nowPage != paging.lastPage}">
								<div class="paging-line">
									<a href="guestList.do?nowPage=${paging.nowPage+1}&del=${del}&where=${where}&query=${query}"><i class="fas fa-angle-right"></i></a>
								</div>
							</c:when>
							<c:when test="${paging.nowPage == paging.lastPage}">
								<div class="paging-line">
									<i class="fas fa-angle-right"></i>
								</div>	
							</c:when>
						
						</c:choose>	
						
						<!-- >> -->
						
					
						<c:if test="${paging.endPage != paging.lastPage }">
							<div class="paging-line">
							<a href="guestList.do?nowPage=${paging.endPage+1}&del=${del}&where=${where}&query=${query}">
							<i class="fas fa-angle-double-right"></i></a>
							</div>
						</c:if>
						<c:if test="${paging.endPage == paging.lastPage}">
							<div class="paging-line">
							<i class="fas fa-angle-double-right"></i>
							</div>
						</c:if>
					
					</div>
				</div>
				<!-- bootStrap table wrapper-->
			</div>
			<!-- tableRespnsible -->
		</div>
		<!-- cardBody-->
	</div>
</form>
<%@ include file="../include/footer.jsp" %>   