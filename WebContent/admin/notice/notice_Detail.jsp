<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<script>
	document.title += ' - 공지사항 목록'
</script>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
	<h1 class="h3 mb-0 text-gray-800">공지사항 관리 - 공지사항 상세</h1>
</div>

<!-- Content Row -->


<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">공지사항 - 상세보기</h1>
<p class="mb-4">
	<a target="_blank" href="https://datatables.net"></a>
</p>
<form method="get" name="formm" action="noticeUpdate.do">
	<!-- DataTales Example -->
	<div class="card shadow mb-4" style="width: 700px">
		<div class="card-header py-2">
			<h6 class="m-1 font-weight-bold text-primary"
				style="line-height: 16px; font-size: 1.3em"></h6>
			<div class="button" style="float: right;">
				<input type="hidden" name="no" value="${notice.noticeNo}">
				<input type="button" value="수정"> <input type="button"
					value="삭제"
					onclick="location.href='noticeDelete.do?no=${notice.noticeNo}'">
			</div>
		</div>

		<!-- card-body -->
		<div class="card-body">
			<div class="table-responsive">
				<!-- bootStrap table wrapper-->
				<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">


					<div id="add-wrapper">

						<div style="text-align: center;">
							<div>
							<label>${notice.noticeTitle}</label><br>
							<hr>
							<label>${notice.noticeContent }</label> <br> 
							</div>
							<div>
							<img alt=""
								src="../notice/setload/${notice.noticeFile }" >
								</div>
						</div>
					</div>
				</div>
				<!-- bootStrap table wrapper-->
			</div>
			<!-- tableRespnsible -->
		</div>
		<!-- cardBody-->
	</div>

</form>



<%@ include file="../include/footer.jsp"%>
