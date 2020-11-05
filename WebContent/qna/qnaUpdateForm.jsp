<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function QnaUpdate() {
		if (confirm("정말 수정하시겠습니까?")) {
			var no = document.getElementById("no").value;
			alert(qna);
			document.form.action = 'qnaUpdate.do?no=' + no;
			document.form.submit();
			return true;
		} else {
			return false;
		}
	};
</script>
</head>
<body>
	<hr>
	${qna}
	<hr>


	<%-- <input type="hidden" value="${qna}" name="qna" id="qna"> --%>
	정말로 수정하시겠습니까?
	<form action="qnaUpdate.do" method="get">
		<input type="hidden" id="no" value="${qna.qnaNo}" name="no">
		<input type="hidden" value="${qna.qnaTitle }" name="title">
		<input type="hidden" value="${qna.qnaContent }" name="content">
		<input type="submit" value="수정">
		<input type="button" value="취소" onclick="QnaCancel()">
	</form>
</body>
</html>