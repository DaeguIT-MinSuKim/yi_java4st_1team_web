<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<h1>문의 공지사항 작성</h1>
<form method="post" action="qnaNoticeWrite.do" enctype="multipart/form-data">
	<div>
		<label>제목</label> <input type="text" id="title" name="title" /><br> <label>내용</label>
		<textarea rows="20" cols="100" id="content" name="content"></textarea>
	</div>
	<div id="button" style="float: right;">
			<input type="reset" value="초기화" />
			<input type="submit" value="등록" /> 
			<input type="button" value="취소" onclick="location.href='qnaList.do'" />
			<input type="file" value="파일첨부" multiple id ="setload" name="setload">
		</div>
</form>
<%@ include file="../include/footer.jsp"%>