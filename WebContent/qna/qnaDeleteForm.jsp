<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function QnaDel() {
		window.opener.top.location.href = "qnaDelete.do?no="+document.getElementById("no").value;
		window.close()
	};
	function QnaCancel() {
		self.close();
	};
</script>
</head>
<body>
	<input type="hidden" id="no" value="${no}" name="no"> 정말로
	삭제하시겠습니까?
	<input type="button" value="삭제" onclick="QnaDel()">
	<input type="button" value="취소" onclick="QnaCancel()">
</body>
</html>