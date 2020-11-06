<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
	document.title += ' - 공지사항 목록'

	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		var sel2 = document.getElementById('selectPage').value;
		location.href = "noticeList.do?nowPage=${paging.nowPage}&cntPerPage="
				+ sel + "&stay=" + sel2
	}

	function tableChange() {
		var sel = document.getElementById('selectPage').value;
		location.href = "noticeList.do?nowPage=${paging.nowPage}&stay=" + sel;
	}

	//전체선택
	function selectAll() {
		$('[name=check]').prop('checked', true);
	};

	//전체선택취소
	function deselectAll() {
		$('[name=check]').prop('checked', false);
	};

	//그룹삭제
	$(document).on('click', '[name=delete]', function() {
		/* $("#dataTable tr:nth-child(2)").css("background", "red"); */
		/*삭제할 정보들을 담을 곳*/
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
		if (confirm(array + "님을 삭제처리 하시겠습니까?") == true) {
			$.ajax({
				type : 'post',
				url : 'noticeDelete.do',
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
	});

	//그룹복원
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
				url : 'noticeRestore.do',
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

	function buttonDel() {
		$('#dataTable tr').click(function() {

			var tr = $(this);
			var td = tr.children();
			var no = td.eq(1).text();
			alert(no);

			if (confirm(no + "번 글을 삭제 처리하시겠습니까?") == true) {
				$.ajax({
					type : 'get',
					url : 'noticeDelete.do',
					data : {
						no : no
					},
					dataTye : "text",
					success : function(res) {
						location.href = "noticeList.do";
						alert("삭제 완료되었습니다.");
						location.reload();
					},
					error : function(res) {
						alert('삭제 시도 중 오류가 발생했습니다.');
					}
				});
			}
		});
	}

	function buttonRestore() {
		$('#dataTable tr').click(function() {

			var tr = $(this);
			var td = tr.children();
			var no = td.eq(1).text();
			alert(no);

			if (confirm(no + "번 글을 복원 하시겠습니까?") == true) {
				$.ajax({
					type : 'get',
					url : 'noticeRestore.do',
					data : {
						no : no
					},
					dataTye : "text",
					success : function(res) {
						location.href = "noticeList.do";
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
<div class="d-sm-flex align-items-center justify-content-between mb-4">
	<h1 class="h3 mb-0 text-gray-800">공지사항 관리 - 공지사항 목록</h1>
</div>
<form method="get" name="formm">
	<div class="card shadow mb-4">
		<div class="card-header py-2">
			<h6 class="m-1 font-weight-bold text-primary"
				style="line-height: 16px; font-size: 1.3em">

				<input type="button" value="등록" class="btn btn-success btn-sm"
					style="float: left; margin-right: 10px;"
					onclick="location.href='noticeInsert.do' ">

				<c:if test="${stay eq 'all' }">
					<input type="button" value="삭제" name="delete"
						class="btn btn-danger btn-sm" id="btn_delete" style="float: left;"
						onclick="checkDelete()">
				</c:if>

				<c:if test="${stay eq 'del' }">
					<input type="button" value="복원" name="Restore"
						class="btn btn-danger btn-sm" id="btn_delete" style="float: left;"
						onclick="checkDelete()">
				</c:if>


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
									class="custom-select custom-select-sm form-control form-control-sm"
									name="stay">
										<option value="all"
											<c:if test="${stay eq 'all'}">selected</c:if>>전체</option>
										<option value="del"
											<c:if test="${stay eq 'del'}">selected</c:if>>삭제</option>
								</select>
								</label>
							</div>


						</div>

						<div class="col-sm-12 col-md-6" style="float: right;">
							<div id="dataTable_filter" class="dataTables_filter ">
								<select class="custom-select custom-select-sm" name="condition"
									style="width: 80px;">
									<option <c:if test="${condition eq 'noticeTitle'}"> selected </c:if> value="noticeTitle">제목</option>
									<option <c:if test="${condition eq 'noticeContent'}"> selected </c:if> value="noticeContent">내용</option>
								</select> <label> <input type="search" name="keyword"
									class="form-control form-control-sm" placeholder=""
									aria-controls="dataTable">
								</label> <input type="submit" value="검색" class="btn btn-primary btn-sm">
							</div>
						</div>
						<!-- 테이블 상단 필터링 끝 -->

						<!-- 테이블 시작 -->
						<table class="table table-bordered text-center" id="dataTable"
							cellspacing="0">
							<thead>
								<tr>
									<th></th>
									<th>번호</th>
									<th>제목</th>
									<th>작성일</th>
									<th style="width: 180px; min-width: 180px; max-width: 180px;"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="notice" items="${viewAll}" varStatus="status">
									<tr>
										<td><input type="checkbox" name="check"
											value="${notice.noticeNo}"></td>
										<td style="width: 20px;">${notice.noticeNo}</td>
										<td style="width: 100px;"><a
											href="noticeDetail.do?no=${notice.noticeNo }">${notice.noticeTitle}</a></td>
										<td style="width: 100px;"><fmt:parseDate
												value="${notice.noticeRegDate}" pattern="yyyy-MM-dd'T'HH:mm"
												var="regDate" type="both" /> <fmt:formatDate
												value="${regDate}" pattern="yyyy-MM-dd HH:mm" /></td>
										<c:if test="${stay eq 'del' }">
											<td><input type="button" name="info" value="복원"
												class="btn bg-gray-200 btn-sm detailViewButton"
												onclick="buttonRestore()"></td>
										</c:if>
										<c:if test="${stay eq 'all' }">
											<td><input type="button" name="info" value="삭제"
												class="btn btn-danger btn-sm deleteButton"
												onclick="buttonDel()"> <input type="button"
												name="info" value="수정" class="btn btn-primary btn-sm"
												onclick="location.href='noticeUpdate.do?no=${notice.noticeNo}'">
												<!-- <input type="button" value="삭제" name="delete" class="btn btn-danger btn-sm" style="float: left;"> -->
											</td>
										</c:if>

									</tr>
								</c:forEach>
							</tbody>
						</table>
						<!-- 테이블 끝 -->

						<div style="width: 100%; margin: 0 auto; text-align: center;">

						<!-- << -->
						<c:if test="${paging.startPage != 1}">
							<div class="paging-line">
								<a
									href="noticeList.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}&stay=${stay}">
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
									<a
										href="noticeList.do?nowPage=${paging.nowPage-1}&cntPerPage=${paging.cntPerPage}&stay=${stay}"><i
										class="fas fa-angle-left"></i></a>
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
									<div class="paging-line" style="font-weight: bold">${p}</div>
								</c:when>
								<c:when test="${p != paging.nowPage }">
									<div class="paging-line">
										<a
											href="noticeList.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}&stay=${stay}">
											${p}</a>
									</div>
								</c:when>
							</c:choose>
						</c:forEach>



						<!-- 다음페이지 -->
						<c:choose>
							<c:when test="${paging.nowPage != paging.lastPage}">
								<div class="paging-line">
									<a
										href="noticeList.do?nowPage=${paging.nowPage+1}&cntPerPage=${paging.cntPerPage}&stay=${stay}"><i
										class="fas fa-angle-right"></i></a>
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
								<a
									href="noticeList.do?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}&stay=${stay}">
									<i class="fas fa-angle-double-right"></i>
								</a>
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
		</div>
	</div>
</form>
<%@ include file="../include/footer.jsp"%>