<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function go_QnaUpdate() {
	var url="qnaUpdateForm.do?title="+document.getElementById("title").value+
			"&content="+document.getElementById("content").value+
			"&no="+document.getElementById("no").value;
	window.open( url, "_blank_1",
	"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=400, height=100");
}
</script>
</head>
<body>
	<h1>문의 수정</h1>
	<form name="form" method="post" action="qnaUpdate.do">
	<input type="hidden" name="no" value="${qna.qnaNo}" id="no">
		<label>제목</label>
		<input type="text" readonly id="title" value="${qna.qnaTitle }"><br>
		<label>내용</label>
		<textarea name="content" id="content">${qna.qnaContent}</textarea><br>
	
	
	<div id="buttons" style="float: right">
		<input type="button" value="수정하기" id="updateButton" onclick="go_QnaUpdate()"> 
		<input type="reset" value="초기화" id="reset" >
		<input type="button" value="취소" id="home" onclick="location.href='qnaHome.do'">
	</div>
	</form>
</body>
</html>