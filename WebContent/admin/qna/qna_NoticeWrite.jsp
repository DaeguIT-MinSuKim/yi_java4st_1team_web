<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<style>
.add-table {
	text-align: left;
}

.add-table tr td:nth-child(2) {
	text-align: left;
}

h3 {
	text-align: center;
}

</style>
<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">문의사항 - 등록</h1>
<p class="mb-4"></p>
<form method="post" action="qnaNoticeWrite.do"
	enctype="multipart/form-data" name="formm">

	<!-- DataTales Example -->
	<div class="card shadow mb-4" style="width: 700px">
		<div class="card-header py-2">
			<h6 class="m-1 font-weight-bold text-primary"
				style="line-height: 16px; font-size: 1.3em"></h6>
		</div>
		<!-- card-body -->
		<div class="card-body">
			<div class="table-responsive">
				<!-- bootStrap table wrapper-->
				<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
					<div id="add-wrapper">
					<h3>공지 등록</h3>
						<table class="add-table">
							<tr style="border-top: 1px solid black;">
								<td>공지명</td>
								<td><input type="text" id="title" name="title" /></td>

							</tr>
							<tr>
								<td>공지내용</td>
								<td><textarea rows="20" cols="60" id="content"
										name="content"></textarea></td>
							</tr>
						</table>
						<input type="file" value="파일첨부" multiple id="setload"
								name="setload" style="width: 100px;">
						<br> <br>
						<div class="clear"></div>
						<br>
						<div class="add-buttons" style="float: right">
							<input type="reset" class="btn btn-primary btn-sm" value="초기화" />
							<input type="submit" class="btn btn-primary btn-sm" value="등록" />
							<input type="button" value="취소" class="btn btn-primary btn-sm"
								onclick="location.href='qnaList.do'" />
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