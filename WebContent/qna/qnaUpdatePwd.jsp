<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>비밀번호</h1>
	<form action="qnaUpdatePwd" method="post">
		<input type="hidden" value="${qna }" name="qna">
		<input type="password" name="password">
		<input type="submit" value="확인">
	</form>
</body>
</html>