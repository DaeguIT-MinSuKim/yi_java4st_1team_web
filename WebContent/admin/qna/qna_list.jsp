<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	document.title += ' - 문의 목록';

	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href = "guestList.do?nowPage=1&cntPerPage=" + sel;
	};

	function selectAll() {
		$('[name=check]').prop('checked', true);
	};

	function deselectAll() {
		$('[name=check]').prop('checked', false);
	};

	$(document).on('click', '[name=delete]', function() {
		/* $("#dataTable tr:nth-child(2)").css("background", "red"); */
		var array = new Array();
		$("#dataTable input[name=check]:checked").each(function() {
			array.push(this.value);
		});
		console.log(array);

		if (array == 0) {
			alert('삭제할 회원을 선택하세요');
			return;
		}

		//셀렉트박스 선택한 사람 배열로 ajax로 넘기기
		if (confirm(array + "님을 탈퇴처리 하시겠습니까?") == true) {
			$.ajax({
				type : 'post',
				url : 'guestDelete.do',
				data : {
					"string" : array
				},
				async : false,
				success : function(JSON) {
					/* alert("성공"); */
					location.reload();
				},
				error : function() {
					alert('삭제할 회원을 선택하세요');
				}
			});
		} else {
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
		var no = $(this).attr('no');
		alert(no);
		if (confirm( no+ '을 삭제처리 하시겠습니까?') == true) {
			location.href = 'qnaDelete.do?no=' + no;
		} else {
			return;
		}

	});
</script>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">문의 목록 - 문의 관리</h1>
<p class="mb-4">
	<a target="_blank" href="https://datatables.net"></a>
</p>
<form method="post" name="formm">
	<!-- DataTales Example -->
	<div class="card-header py-2">
		<h6 class="m-1 font-weight-bold text-primary"
			style="line-height: 16px; font-size: 1.3em">

			<input type="button" value="공지 등록" class="btn btn-success btn-sm"
				style="float: left; margin-right: 10px;"
				onclick="location.href='qnaNoticeWrite.do'"> <input type="button"
				value="삭제" name="delete" class="btn btn-danger btn-sm"
				style="float: left;">

			<button type="button" onclick="selectAll()"
				class="btn btn-secondary btn-sm"
				style="float: right; margin-right: 10px;">전체선택</button>
			<button type="button" onclick="deselectAll()"
				class="btn btn-outline-secondary btn-sm"
				style="float: right; margin-right: 10px;">선택해제</button>
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
						<div class="dataTables_length" id="dataTable_length">
							<label> <select name="dataTable_length" id="cntPerPage"
								onchange="selChange()" aria-controls="dataTable"
								class="custom-select custom-select-sm form-control form-control-sm">
									<option value="5"
										<c:if test="${paging.cntPerPage == 5}">selected</c:if>>5줄
										보기</option>
									<option value="10"
										<c:if test="${paging.cntPerPage == 10}">selected</c:if>>10줄
										보기</option>
									<option value="15"
										<c:if test="${paging.cntPerPage == 15}">selected</c:if>>15줄
										보기</option>
									<option value="20"
										<c:if test="${paging.cntPerPage == 20}">selected</c:if>>20줄
										보기</option>
							</select>
							</label>
						</div>
					</div>
					<div class="col-sm-12 col-md-6">
						<div id="dataTable_filter" class="dataTables_filter ">
							<select class="custom-select custom-select-sm" name="opt"
								style="width: 80px;">
								<option value="0">아이디</option>
								<option value="1">제목</option>
							</select> <label> <input type="text" name="value"
								class="form-control form-control-sm" placeholder=""
								aria-controls="dataTable">
							</label> <input type="submit" value="검색" class="btn btn-primary btn-sm">
						</div>
					</div>
				</div>
				<!-- 테이블 상단 필터링 끝 -->

				<!-- 테이블 시작 -->
				<table class="table table-bordered text-center" id="dataTable"
					width="100%" cellspacing="0">
					<thead>
						<tr>
							<th></th>
							<th></th>
							<th>아이디</th>
							<th>제목</th>
							<th>작성일</th>
							<th>답변여부</th>
							
							<th>답변</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="qna" items="${viewAll}" varStatus="status">
							<tr>
								<td><input type="checkbox" name="check" value="${qna.qnaNo}"></td>
								<td style="width: 20px;">${total - ((paging.nowPage-1) * cnt + status.index)}</td>
								<td style="width: 80px;">${qna.guestId.guestId}</td>
								<td style="width: 130px;">${qna.qnaTitle}</td>
								<td style="width: 150px;">${qna.qnaRegDate}</td>
								<td style="width: 150px;">${qna.qnaResYn}</td>
								
								
								<td style="width: 100px;">
								<c:choose>
									<c:when test="${qna.qnaResYn eq 'y'}">
									<a href="#" class="btn bg-warning btn-sm bookingToOrderButton">
									<span class="text-gray-800">답변완료</span>
									</a>
									</c:when>
									<c:otherwise>
									<a href="#" class="btn bg-warning btn-sm bookingToOrderButton">
									<span class="text-gray-800">답변하기</span>
									</a>
									</c:otherwise>
								</c:choose>
								</td>
										
								<td style="width: 100px;"><input type="button"
									name="update" value="수정" class="btn btn-dark btn-sm"
									onclick="location.href='guestInfo.do?id=${guest.guestId}'">
									<input type="button" value="삭제" id="btn_delete"
									 class="btn btn-danger btn-sm" no="${qna.qnaNo}">
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- 테이블 끝 -->


				<div style="text-align: center; float: center;">
					<p>Total : ${total}</p>


					<c:if test="${paging.startPage != 1}">
						<a
							href="guestList.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}">
							<i class="xi-angle-left"></i>
						</a>
					</c:if>

					<c:forEach begin="${paging.startPage}" end="${paging.endPage }"
						var="p">
						<c:choose>
							<c:when test="${p == paging.nowPage }">
								${p}
								</c:when>
							<c:when test="${p != paging.nowPage }">
								<a
									href="guestList.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}"><b
									style="margin: 5px;">${p}</b></a>
							</c:when>
						</c:choose>
					</c:forEach>

					&nbsp;&nbsp;
					<c:if test="${paging.endPage != paging.lastPage }">
						<a
							href="guestList.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">
							<i class="xi-angle-right"></i>
						</a>
					</c:if>


				</div>
			</div>
			<!-- bootStrap table wrapper-->
		</div>
		<!-- tableRespnsible -->
	</div>
	<!-- cardBody-->
	<!-- 	</div>
</div> -->
</form>
<%@ include file="../include/footer.jsp"%>
