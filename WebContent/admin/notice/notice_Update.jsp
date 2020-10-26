<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<script>
	function insertNotice() {
		var title = $('#title').val();
		var content = $('textarea#content').val();
		var no = $('#no').val();

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
					location.href="noticeList.do";
					alert("수정이 완료되었습니다.");
					location.reload;
				},
				error : function(res) {
					alert('수정 시도 중 오류가 발생하였습니다.');
				}
			});
		}
	}
</script>
<h1>공지사항 작성</h1>
<div>
	<label>제목</label> <input type="text" id="title" value="${notice.noticeTitle }"/><br> <label>내용</label>
	<textarea rows="30" cols="100" id="content" >${notice.noticeContent }</textarea>

	<div id="button" style="float: right;">
		<input type="reset" value="초기화" />
		<input type="button" value="수정완료" onclick="insertNotice()" />
		<input type="button" value="취소" onclick="location.href='noticeList.do'" />
		<input type="hidden" value="${notice.noticeNo }" id="no">
	</div>
</div>


<%@ include file="../include/footer.jsp"%>