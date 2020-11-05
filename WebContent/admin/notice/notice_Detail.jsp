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
</style>
<script>
	function date_check() {
		var start = $("#startDate").val();
		var end = $("#endDate").val();
		$("#endDate").attr("min", start)
	}
</script>
<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">공지사항 관리</h1>
<p class="mb-4"></p>
<form method="get" name="formm" action="noticeUpdate.do">
	<!-- DataTales Example -->
	<div class="card shadow mb-4" style="width: 700px">
		<div class="card-header py-2">
			<h6 class="m-1 font-weight-bold text-primary"
				style="line-height: 16px; font-size: 1.3em">공지상세 보기</h6>
		</div>
		<!-- card-body -->
		<div class="card-body">
			<div class="table-responsive">
				<!-- bootStrap table wrapper-->
				<div class="dt-bootstrap4">


					<div id="add-wrapper">

						<table class="add-table">
							<tr style="border-top: 1px solid black;">
								<td>번호</td>
								<td>${notice.noticeNo}<input type="hidden" name="no"
									value="${notice.noticeNo}"></td>
							</tr>
							<tr>
								<td>공지명</td>
								<td>${notice.noticeTitle }</td>

							</tr>
							<tr>
								<td>공지 상태</td>
								<td><c:if test="${notice.noticeDelYn == 'n'}">
										<div class="btn-info btn-sm" style="width: 80px;">진행중</div>
									</c:if> <c:if test="${notice.noticeDelYn == 'y'}">
										<div class="btn-secondary btn-sm" style="width: 80px;">종료</div>
									</c:if></td>

							</tr>
							<tr>
								<td>공지 내용</td>
								<td>${notice.noticeContent}</td>
							</tr>

							<tr>
								<td>공지 게시일</td>
								<td><fmt:parseDate value="${notice.noticeRegDate}"
										pattern="yyyy-MM-dd'T'HH:mm" var="regDate" type="both" /> <fmt:formatDate
										value="${regDate}" pattern="yyyy-MM-dd HH:mm" /></td>
							</tr>
						</table>
						<br> <br>
						<div class="clear"></div>
						<br>
						<c:if test="${notice.noticeFile != null }">
							<img alt="" src="../notice/setload/${notice.noticeFile}"
								style="width: 600px; height: 600px;">
						</c:if>
						<br> <br>
						<div class="add-buttons" style="float: right">
							<input type="submit" value="수정" class="btn btn-primary btn-sm">
							<input type="button" class="btn btn-primary btn-sm" value="삭제"
								onclick="location.href='noticeDelete.do?no=${notice.noticeNo}'">
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
