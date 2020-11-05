<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.add-table td {
	padding: 10px;
}

.add-table tr td:nth-child(1) {
	width: 100px;
}

.add-table tr td:nth-child(2) {
	text-align: left;
}

h3 {
	text-align: center;
}

.resCard {
	width: 99%;
	background-color: #F6F6F6;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
}
</style>
<!-- Page Heading -->

<h1 class="h3 mb-2 text-gray-800 font-weight">문의사항 - 답변및공지 수정하기</h1>
<p class="mb-4"></p>
<form method="post" action="qnaUpdate.do" enctype="multipart/form-data">

	<!-- DataTales Example -->
	<div class="card shadow mb-4" style="width: 700px">
		<div class="card-header py-2">
			<h6 class="m-1 font-weight-bold text-primary"
				style="line-height: 16px; font-size: 1.3em">문의및공지 수정</h6>
		</div>
		<!-- card-body -->
		<div class="card-body">
			<div class="table-responsive">
				<!-- bootStrap table wrapper-->
				<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
					<div id="add-wrapper">
						<c:if test="${qna.qnaNotice eq 'y' }">
							<h3>공지</h3>
							<table class="add-table">
								<tr style="border-top: 1px solid black;">
									<td>번호</td>
									<td>${qna.qnaNo}<input type="hidden" name="no"
										value="${qnaRes.qnaNo}"></td>
								</tr>
								<tr>
									<td>공지명</td>
									<td><input type="text" name="title"
										value="${qna.qnaTitle }" /></td>
								</tr>
								<tr>
									<td>공지 작성일</td>
									<td><fmt:parseDate value="${qna.qnaRegDate}"
											pattern="yyyy-MM-dd'T'HH:mm" var="regDate" type="both" /> <fmt:formatDate
											value="${regDate}" pattern="yyyy-MM-dd HH:mm" /></td>
								</tr>
								<tr>
									<td>공지 상태</td>
									<td><c:if test="${qna.qnaDelYn eq 'n'}">
											<div class="btn-info btn-sm"
												style="width: 80px; text-align: left;">진행중</div>
										</c:if> <c:if test="${qna.qnaDelYn eq 'y'}">
											<div class="btn-secondary btn-sm"
												style="width: 80px; margin: 0 auto">종료</div>
										</c:if></td>
								</tr>
								<tr>
									<td>공지 내용</td>
									<td><textarea rows="20" cols="60" name="content"
											style="resize: none;">${qna.qnaContent }</textarea></td>
								</tr>
							</table>
							<br>
							<img alt="" src="../notice/setload/${qna.qnaFile}"
								style="max-width: 100%; height: auto;">
							<input type="file" value="파일첨부" multiple id="setload"
								name="setload" style="width: 100px;">
						</c:if>
						<c:if test="${qna.qnaNotice eq 'n' }">
							<h3>문의</h3>
							<table class="add-table">
								<tr style="border-top: 1px solid black;">
									<td>번호</td>
									<td>${qna.qnaNo}<input type="hidden" name="no"
										value="${qnaRes.qnaNo}"></td>
								</tr>
								<tr>
									<td>문의명</td>
									<td>${qna.qnaTitle }</td>

								</tr>
								<tr>
									<td>문의 작성일</td>
									<td><fmt:parseDate value="${qna.qnaRegDate}"
											pattern="yyyy-MM-dd'T'HH:mm" var="regDate" type="both" /> <fmt:formatDate
											value="${regDate}" pattern="yyyy-MM-dd HH:mm" /></td>
								</tr>
								<tr>
									<td>문의 상태</td>
									<td><c:if test="${qna.qnaDelYn eq 'n'}">
											<div class="btn-info btn-sm"
												style="width: 80px; text-align: left;">진행중</div>
										</c:if> <c:if test="${qna.qnaDelYn eq 'y'}">
											<div class="btn-secondary btn-sm"
												style="width: 80px; text-align: left;">종료</div>
										</c:if></td>
								</tr>
								<tr>
									<td>문의 내용</td>
									<td>${qna.qnaContent}</td>
								</tr>
							</table>
							<br>
							<c:if test="${qna.qnaFile != null}">
								<img alt="" src="../qna/upload/${qna.qnaFile}">
							</c:if>
							<br>
							<br>
							<div class="resCard">
								<h3>답변</h3>
								<table class="add-table">
									<tr style="border-top: 1px solid black;">
										<td>번호</td>
										<td>${qnaRes.qnaNo}<input type="hidden" name="no"
											value="${qnaRes.qnaNo}"></td>
									</tr>
									<tr>
										<td>답변 제목</td>
										<td><input type="text" name="title"
											value="${qnaRes.qnaTitle }" />
									</tr>
									<tr>
										<td>답변 내용</td>
										<td><textarea rows="20" cols="60" name="content"
												style="resize: none;">${qnaRes.qnaContent }</textarea></td>
									</tr>
								</table>
								<br>
								<c:if test="${qnaRes.qnaFile != null}">
									<img alt="" src="../notice/setload/${qnaRes.qnaFile}">
								</c:if>
								<br> <input type="file" value="파일첨부" multiple id="setload"
									name="setload" style="width: 100px;">
							</div>
						</c:if>

						<br> <br>
						<div class="clear"></div>
						<br>
						<div class="add-buttons" style="float: right">
							<input type="submit" value="수정" class="btn btn-primary btn-sm">
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