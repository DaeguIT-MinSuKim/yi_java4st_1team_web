<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function go_delQna() {
	var url="qnaDeleteForm.do";
	window.open( url, "_blank_1",
	"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=400, height=100");
}
</script>
</head>
<body>
	<h1>문의 수정</h1>
	<form name="form" method="post" action="qnaUpdate.do">
	<input type="hidden" name="no" value="${qna.qnaNo}">
		<label >${qna.qnaTitle }</label>
		<label>내용</label>
		<textarea name="content">${qna.qnaContent}</textarea><br>
	
	
	<div id="buttons" style="float: right">
		<input type="submit" value="수정하기" id="updateButton"> 
		<input type="reset" value="초기화" id="reset" >
		<input type="button" value="취소" id="home" onclick="location.href='qnaList.do'">
	</div>
	</form>
</body>
</html>