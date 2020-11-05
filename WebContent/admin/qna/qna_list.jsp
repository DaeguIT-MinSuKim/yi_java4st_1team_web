<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.leftTd {
	text-align: left;
}
</style>
<script>
	document.title += ' - 문의 목록';

	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		var sel2 = document.getElementById('selectPage').value;
		location.href = "qnaList.do?nowPage=1&cntPerPage=" + sel + "&stay="
				+ sel2;
	};
	function tableChange() {
		var sel = document.getElementById('selectPage').value;
		alert(sel);
		location.href = "qnaList.do?nowPage=${paging.nowPage}&stay=" + sel;
	}

	/* 전체 선택 */
	function selectAll() {
		$('[name=check]').prop('checked', true);
	};

	/* 전체 해체 */
	function deselectAll() {
		$('[name=check]').prop('checked', false);
	};

	/* 그룹삭제 */
	$(document).on('click', '[name=delete]', function() {
		/* $("#dataTable tr:nth-child(2)").css("background", "red"); */
		var array = new Array();
		$("#dataTable input[name=check]:checked").each(function() {
			array.push(this.value);
		});
		console.log(array);

		if (array == 0) {
			alert('삭제할 문의을 선택하세요');
			return;
		}

		//셀렉트박스 선택한 사람 배열로 ajax로 넘기기
		if (confirm(array + "을 삭제처리 하시겠습니까?") == true) {
			$.ajax({
				type : 'post',
				url : 'qnaDelete.do',
				data : {
					"string" : array
				},
				async : false,
				success : function(JSON) {
					/* alert("성공"); */
					location.reload();
				},
				error : function() {
					alert('삭제할 문의을 선택하세요');
				}
			});
		} else {
			return;
		}

	});

	$(document).on('click', '[id=btn_delete]', function() {
		var no = $(this).attr('no');

		if (confirm(no + '를 삭제처리 하시겠습니까?') == true) {
			location.href = "qnaDelete.do?no=" + no;
		} else {
			return;
		}

	});

	//그룹 복원
	$(document).on('click', '[name=Restore]', function() {
		/* $("#dataTable tr:nth-child(2)").css("background", "red"); */
		/*복원할 정보들을 담을 곳*/
		var array = new Array();

		/*dataTable의 input태그에 check가 checked되어 있는 거에 각각 배열에 no를 넣는다. */
		$("#dataTable input[name=check]:checked").each(function() {
			array.push(this.value);
		});

		console.log(array);

		/* if(array==0){
			alert('삭제할 회원을 선택하세요');
			return;
		}
		 */

		/* 확인창을 띄워서 확인한다. */
		if (confirm(array + "님을 복원처리 하시겠습니까?") == true) {
			$.ajax({
				type : 'post',
				url : 'qnaRestore.do',
				data : {
					"string" : array
				},
				async : false,
				success : function(JSON) {
					/* alert("성공"); */
					location.reload();
				},
				error : function() {
					alert('복원할 회원을 선택하세요');
				}
			});
		} else {
			return;
		}
	});

	/* 단일복원 */
	function buttonRestore() {
		$('#dataTable tr').click(function() {

			var tr = $(this);
			var td = tr.children();
			var no = td.eq(1).text();
			alert(no);

			if (confirm(no + "번 글을 복원 하시겠습니까?") == true) {
				$.ajax({
					type : 'get',
					url : 'qnaRestore.do',
					data : {
						no : no
					},
					dataTye : "text",
					success : function(res) {
						location.href = "qnaList.do";
						alert("복원 완료되었습니다.");
						location.reload();
					},
					error : function(res) {
						alert('복원 시도 중 오류가 발생했습니다.');
					}
				});
			}
		});
	}
</script>
<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">문의 목록 - 문의 관리</h1>
<p class="mb-4">
	<a target="_blank" href="https://datatables.net"></a>
</p>
<form method="get" name="formm">
	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-2">
			<h6 class="m-1 font-weight-bold text-primary"
				style="line-height: 16px; font-size: 1.3em">
				<input type="button" value="공지 등록" class="btn btn-success btn-sm"
					style="float: left; margin-right: 10px;"
					onclick="location.href='qnaNoticeWrite.do'">
				<c:choose>
					<c:when test="${stay eq 'delq' || stay eq 'deln'}">
						<input type="button" value="복원" name="Restore"
							class="btn btn-danger btn-sm" style="float: left;">
					</c:when>
					<c:otherwise>
						<input type="button" value="삭제" name="delete"
							class="btn btn-danger btn-sm" style="float: left;">
					</c:otherwise>
				</c:choose>


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
								<label> <select name="cntPerPage" id="cntPerPage"
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
								</select> <select name="stay" id="selectPage" onchange="tableChange()"
									aria-controls="dataTable"
									class="custom-select custom-select-sm form-control form-control-sm">
										<option value="all"
											<c:if test="${stay eq 'all'}">selected</c:if>>전체</option>
										<option value="resy"
											<c:if test="${stay eq 'resy'}">selected</c:if>>답변된문의
										</option>
										<option value="resn"
											<c:if test="${stay eq 'resn'}">selected</c:if>>미답변된공지
										</option>
										<option value="delq"
											<c:if test="${stay eq 'delq'}">selected</c:if>>삭제된문의
										</option>
										<option value="deln"
											<c:if test="${stay eq 'deln'}">selected</c:if>>삭제된공지
										</option>
								</select>

								</label>
							</div>
						</div>
						<div class="col-sm-12 col-md-6">
							<div id="dataTable_filter" class="dataTables_filter ">
								<select class="custom-select custom-select-sm" name="condition"
									style="width: 80px;">
									<option
										<c:if test="${condition eq 'qnaTitle'}"> selected </c:if>
										value="qnaTitle">제목</option>
									<option
										<c:if test="${condition eq 'qnaContent'}"> selected </c:if>
										value="qnaContent">내용</option>
									<option
										<c:if test="${condition eq 'qnaWriter'}"> selected </c:if>
										value="qnaWriter">작성자</option>
								</select> <label> <input type="search" name="keyword"
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
								<th>처리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="qna" items="${viewAll}" varStatus="status">
								<c:if test="${qna.qnaNotice eq 'y'}">
									<tr style="background-color: #BCBCD9">
								</c:if>
								<c:if test="${qna.qnaNotice eq 'n'}">
									<tr>
								</c:if>
								<td><input type="checkbox" name="check"
									value="${qna.qnaNo}"></td>
								<td style="width: 20px;">${qna.qnaNo}</td>
								<td style="width: 80px;" class="leftTd">${qna.guestId.guestId}</td>
								<td style="width: 130px;" class="leftTd"><a
									href="qnaDetail.do?no=${qna.qnaNo }"><c:if
											test="${qna.qnaNotice eq 'y'}">
											<i class="fas fa-flag"></i>
										</c:if> <c:if test="${qna.qnaSecret eq 'y'}">
											<i class="fas fa-lock"></i>
										</c:if>${qna.qnaTitle}</a></td>
								<td style="width: 150px;"><fmt:parseDate
										value="${qna.qnaRegDate}" pattern="yyyy-MM-dd'T'HH:mm"
										var="regDate" type="both" /> <fmt:formatDate
										value="${regDate}" pattern="yyyy-MM-dd HH:mm" /></td>
								<td style="width: 150px;"><c:if
										test="${qna.qnaNotice eq 'n' }">
										<c:if test="${qna.qnaResYn eq 'y' }">
											<i class="fas fa-check" style="color: #09D345;"></i>
										</c:if>

									</c:if></td>

								<td style="width: 100px;"><c:if
										test="${qna.qnaResYn eq 'y'}">
										<a href="#" class="btn bg-gray-200 btn-sm detailViewButton">
											<span class="text-gray-800">답변완료</span>
										</a>
									</c:if> <c:if test="${qna.qnaResYn eq 'n' && qna.qnaNotice eq 'n'}">
										<a href="qnaResult.do?no=${qna.qnaNo }"
											class="btn bg-warning btn-sm bookingToOrderButton"> <span
											class="text-gray-800">답변하기</span>
										</a>
									</c:if> <c:if test="${qna.qnaNotice eq 'y'}">
									</c:if></td>

								<td style="width: 100px;"><c:choose>
										<c:when test="${stay eq 'delq' || stay eq 'deln'}">
											<input type="button" name="update" value="복원"
												class="btn btn-dark btn-sm" onclick="buttonRestore()">
										</c:when>
										<c:otherwise>
											<c:if test="${qna.qnaResYn eq 'y' || qna.qnaNotice eq 'y' }">
												<input type="button" name="update" value="수정"
													class="btn btn-primary btn-sm"
													onclick="location.href='qnaUpdate.do?no=${qna.qnaNo}'">
											</c:if>
											<input type="button" value="삭제" id="btn_delete"
												no="${qna.qnaNo}" class="btn btn-danger btn-sm">
										</c:otherwise>
									</c:choose></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<!-- 테이블 끝 -->


					<div style="text-align: center; float: center;">
						<p>Total : ${total}</p>


						<c:if test="${paging.startPage != 1}">
							<a
								href="qnaList.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}">
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
										href="qnaList.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}"><b
										style="margin: 5px;">${p}</b></a>
								</c:when>
							</c:choose>
						</c:forEach>

						&nbsp;&nbsp;
						<c:if test="${paging.endPage != paging.lastPage }">
							<a
								href="qnaList.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">
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
	</div>
</form>
<%@ include file="../include/footer.jsp"%>
