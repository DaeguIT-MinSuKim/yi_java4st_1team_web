<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section style="width: 450px; height: auto;">
		<form action="qnaConfirmPassword.do" method="post">
			<h1>비밀번호 입력</h1>
			<input type="password" name="pwd"> <input type="hidden"
				name="no" value="${qnaNo}">
	</form>
	</section>
</body>
</html>