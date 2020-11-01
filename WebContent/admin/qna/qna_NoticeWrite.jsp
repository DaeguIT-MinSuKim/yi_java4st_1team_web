<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">문의사항 - 공지쓰기</h1>
<p class="mb-4">
	<a target="_blank" href="https://datatables.net"></a>
</p>
<form method="post" action="qnaNoticeWrite.do"
	enctype="multipart/form-data" name="formm">

	<!-- DataTales Example -->
	<div class="card shadow mb-4" style="width: 700px">
		<div class="card-header py-2">
			<h6 class="m-1 font-weight-bold text-primary"
				style="line-height: 16px; font-size: 1.3em"></h6>
			<div id="button" style="float: right;">
				<input type="reset" value="초기화" /> <input type="submit" value="등록" />
				<input type="button" value="취소" onclick="location.href='qnaList.do'" />
				<input type="file" value="파일첨부" multiple id="setload" name="setload">
			</div>
		</div>

		<!-- card-body -->
		<div class="card-body">
			<div class="table-responsive">
				<!-- bootStrap table wrapper-->
				<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">


					<div id="add-wrapper">

						<table class="add-table">

							<tr>
								<td>제목</td>
								<td><input type="text" id="title" name="title" /></td>
							</tr>


							<tr>
								<td>내용</td>
								<td><textarea rows="20" cols="60" id="content" name="content"></textarea></td>
							</tr>
							<tr>
								<td>업로드 사진</td>
								<td><input type="file" name="setload"></td>
							</tr>

						</table>
						<br>
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