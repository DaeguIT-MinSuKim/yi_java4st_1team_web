<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
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
	$(function() {
		$("#modifyBtn").click(function() {
			insertNotice();
		});
	});

	function insertNotice() {
		var title = $('#title').val();
		var content = $('#noticeContent').val();
		var no = $('#no').val();
		console.log($("#noticeContent").val());

		if (confirm(title + "을 수정하시겠습니까?") == true) {
			$.ajax({
				type : 'post',
				url : 'noticeUpdate.do',
				data : {
					no : no,
					title : title,
					content : content

				},
				dataType : "text",
				success : function(res) {
					if (res == 1) {
						console.log(res);
						alert("수정이 완료되었습니다.");
						location.href = "noticeList.do";
					} else {
						alert("에러 발생");
					}
				},
				error : function(res) {
					console.log(res);
					alert('수정 시도 중 오류가 발생하였습니다.');
				}
			});
		}
	}
</script>
<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">공지사항 관리</h1>
<p class="mb-4"></p>
<form>
	<!-- DataTales Example -->
	<div class="card shadow mb-4" style="width: 700px">
		<div class="card-header py-2">
			<h6 class="m-1 font-weight-bold text-primary"
				style="line-height: 16px; font-size: 1.3em">공지 수정</h6>
		</div>
		<!-- card-body -->
		<div class="card-body">
			<div class="table-responsive">
				<!-- bootStrap table wrapper-->
				<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">


					<div id="add-wrapper">

						<table class="add-table">
							<tr style="border-top: 1xp solid black;">
								<td>번호</td>
								<td>${notice.noticeNo}<input type="hidden" name="no"
									value="${notice.noticeNo}"></td>
							</tr>
							<tr>
								<td>공지명</td>
								<td><input type="text" name="name" id="title"
									value="${notice.noticeTitle }"></td>

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
								<td><textarea rows="20" cols="60" id="noticeContent"
										name="content" style="resize: none;">${notice.noticeContent}</textarea>
								</td>
							</tr>

						</table>

						<br> <br>
						<div class="clear"></div>
						<br> <img alt="" src="../notice/setload/${notice.noticeFile}"
							style="width: 600px; height: 600px;"><br> <br>
						<div class="add-buttons" style="float: right">
							<input type="reset" value="초기화" class="btn btn-primary btn-sm">
							<input type="button" value="수정완료" id="modifyBtn"
								class="btn btn-primary btn-sm"> <input type="button"
								value="취소" class="btn btn-primary btn-sm"
								onclick="location.href='noticeList.do'"> <input
								type="hidden" value="${notice.noticeNo }" id="no">

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