<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<h1 class="h3 mb-2 text-gray-800 font-weight">문의사항 - 답변하기</h1>
<p class="mb-4">
	<a target="_blank" href="https://datatables.net"></a>
</p>
<form method="post" action="qnaResult.do" enctype="multipart/form-data"
	name="formm">

	<!-- DataTales Example -->
	<div class="card shadow mb-4" style="width: 700px">
		<div class="card-header py-2">
			<h6 class="m-1 font-weight-bold text-primary"
				style="line-height: 16px; font-size: 1.3em"></h6>
			<div class="add-buttons" style="float: right">
				<input type="submit" value="등록" class="btn btn-primary btn-sm">
				<input type="button" value="홈으로" class="btn btn-light btn-sm"
					onclick="location.href='qnaList.do'"> <input type="reset"
					value="초기화" class="btn btn-light btn-sm" />
			</div>
		</div>

		<!-- card-body -->
		<div class="card-body">
			<div class="table-responsive">
				<!-- bootStrap table wrapper-->
				<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">


					<div id="add-wrapper">

						<input type="hidden" name="no" value="${qna.qnaNo }">
						<table class="add-table">

							<tr>
								<td>문의 제목</td>
								<td><input type="text" readonly value="${qna.qnaTitle }" />
							</tr>


							<tr>
								<td>문의 내용</td>
								<td><input type="text" readonly value="${qna.qnaContent }" /></td>
							</tr>


							<tr>
								<td>업로드 사진</td>
								<c:if test="${qna.qnaNotice eq 'y' }">
									<td><img alt="" src="../notice/setload/${qna.qnaFile }"></td>
								</c:if>
								<c:if test="${qna.qnaNotice eq 'n' }">
									<td><img alt="" src="../qna/upload/${qna.qnaFile }"></td>
								</c:if>
							</tr>

						</table>
						<br>

						<table class="add-table">

							<tr>
								<td>답변 제목</td>
								<td><input type="text" name="title" />
							</tr>


							<tr>
								<td>답변 내용</td>
								<td><textarea rows="20" cols="60" name="content"></textarea></td>
							</tr>


							<tr>
								<td>업로드 사진</td>
								<td><input type="file" name="setload" multiple></td>
							</tr>

						</table>

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