<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 상세</title>
</head>
<body>
	<h1>문의 상세</h1>
	<form name="form" method="post" action="qnaWrite.do">
		<label >${qna.qnaTitle }</label>
		<label>내용</label>
		<textarea>${qna.qnaContent}</textarea><br>
	</form>
	
	<div id="buttons" style="float: right">
		<input type="button" value="수정하기" class="update" onclick="location.href='qnaUpdate.do?no=${qna.qnaNo}'"> 
		<input type="button" value="삭제하기" class="delete" onclick="location.href='qnaDelete.do?no=${qna.qnaNo}'">
		<input type="button" value="문의홈" class="home" onclick="location.href='qnaHome.do'">
		 <input type="button" value="목록보기" class="list" onclick="location.href='qnaList.do'">
	</div>
</body>
</html>