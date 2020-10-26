<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<script>
	function insertNotice() {
		var title = $('#title').val();
		var content = $('textarea#content').val();

		if (confirm(title + "을 등록하시겠습니까?") == true) {
			$.ajax({
				type : 'post',
				url : 'noticeInsert.do',
				data : {
					title : title,
					content : content
					
				},
				dataType : "text",
				success : function(res) {
					location.href="noitceList.do";
					alert("등록이 완료되었습니다.");
					location.reload;
				},
				error : function(res) {
					alert('등록 시도 중 오류가 발생하였습니다.');
				}
			});
		}
	}
</script>
<h1>공지사항 작성</h1>
<div>
	<label>제목</label> <input type="text" id="title" /><br> <label>내용</label>
	<textarea rows="30" cols="100" id="content"></textarea>

	<div id="button" style="float: right;">
		<input type="reset" value="초기화" /> <input type="button" value="등록"
			onclick="insertNotice()" /> <input type="button" value="취소"
			onclick="location.href='noticeList.do'" />
	</div>
</div>


<%@ include file="../include/footer.jsp"%>