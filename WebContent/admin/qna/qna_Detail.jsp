<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">문의사항 - 상세보기</h1>
<p class="mb-4">
	<a target="_blank" href="https://datatables.net"></a>
</p>
<form name="formm">

	<!-- DataTales Example -->
	<div class="card shadow mb-4" style="width: 700px">
		<div class="card-header py-2">
			<h6 class="m-1 font-weight-bold text-primary"
				style="line-height: 16px; font-size: 1.3em"></h6>
			<div class="add-buttons" style="float: right">
				<input type="button" value="홈으로" class="btn btn-light btn-sm"
					onclick="location.href='qnaList.do'">

			</div>
		</div>

		<!-- card-body -->
		<div class="card-body">
			<div class="table-responsive">
				<!-- bootStrap table wrapper-->
				<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">


					<div id="add-wrapper">

						<table class="add-table" style="width: 50%">

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

						<c:if test="${qna.qnaResYn eq 'y' }">
							<table class="add-table" style="width: 50%">

								<tr>
									<td>답변 제목</td>
									<td><input type="text" name="title" readonly
										value="${qnaResult.qnaTitle }" />
								</tr>


								<tr>
									<td>답변 내용</td>
									<td><input type="text" readonly
										value="${qnaResult.qnaContent }" /></td>
								</tr>


								<tr>
									<td>업로드 사진</td>
									<c:if test="${qna.qnaNotice eq 'y' || qna.qnaRefNo != null }">
										<td><img alt=""
											src="../notice/setload/${qnaResult.qnaFile }"></td>
									</c:if>
									<c:if test="${qna.qnaNotice eq 'n' }">
										<td><img alt="" src="../qna/upload/${qnaResult.qnaFile }"></td>
									</c:if>
								</tr>

							</table>
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
<%@ include file="../include/footer.jsp"%>