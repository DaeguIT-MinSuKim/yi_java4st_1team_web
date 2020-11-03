<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">문의사항 - 답변하기</h1>
<p class="mb-4"></p>
<form method="post" action="qnaResult.do" enctype="multipart/form-data"
	name="formm">

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

						<table class="add-table">
							<tr>
								<td>번호</td>
								<td>${qna.qnaNo}<input type="hidden" name="no"
									value="${qna.qnaNo}"></td>
							</tr>
							<tr>
								<td>문의명</td>
								<td><input type="text" name="name" value="${qna.qnaTitle }"
									readonly></td>

							</tr>
							<tr>
								<td>문의 상태</td>
								<td><c:if test="${qna.qnaDelYn eq 'n'}">
										<div class="btn-info btn-sm"
											style="width: 80px; margin: 0 auto">진행중</div>
									</c:if> <c:if test="${qna.qnaDelYn eq 'y'}">
										<div class="btn-secondary btn-sm"
											style="width: 80px; margin: 0 auto">종료</div>
									</c:if></td>

							</tr>
							<tr>
								<td>문의 내용</td>
								<td><input type='text' name="content"
									value="${qna.qnaContent}" style="height: 60px;" readonly /></td>
							</tr>
							<tr>
								<td>문의 작성일</td>
								<td>${qna.qnaRegDate}</td>
							</tr>

							<c:if test="${qna.qnaFile != null}">
								<tr>
									<td>사진</td>
									<td><img alt="" src="../notice/setload/${qna.qnaFile}">
									</td>
								</tr>
							</c:if>


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

						<br> <br>
						<div class="clear"></div>
						<br>
						<div class="add-buttons" style="float: right">
							<input type="submit" value="등록" class="btn btn-primary btn-sm">
							<input type="reset" value="초기화" class="btn btn-primary btn-sm">
							<input type="button" value="취소" class="btn btn-primary btn-sm"
								onclick="location.href='qnaList.do'">
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