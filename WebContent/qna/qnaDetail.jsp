<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp" %>  
<script>
function go_delQna() {
	var url="qnaDeleteForm.do?no="+document.getElementById("no").value;
	window.open( url, "_blank_1",
	"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=400, height=100");
}
</script>
<body>
	<h1>문의 상세</h1>
	<form name="form" method="get" action="qnaUpdate.do">
		<input type="hidden" name="no" value="${qna.qnaNo}" id="no"><br>
		<label >${qna.qnaTitle }</label><br>
		<label>내용</label><br>
		<textarea readonly>${qna.qnaContent}</textarea><br>
	
	<hr><hr>
		<h1>${resQna.qnaTitle }</h1>
		<br>${resQna.qnaContent}
		<hr>
	
	<div id="buttons" style="float: right">
	<!--비회원이 비회원글에들어와서 비밀번호 맞고 그다음에 수정가능이잖아  -->
	<c:if test="${loginUser.guestId eq qna.guestId.guestId || confirmRes eq y || (qna.guestId eq null && qna.secret eq 'n')}">
		<input type="submit" value="수정하기" id="updateButton" onclick="location.href='qnaUpdate.do?no=${qna.qnaNo}'"> 
		<input type="button" value="삭제하기" id="delete" onclick="go_delQna()">
	</c:if>
		<input type="button" value="문의홈" id="home" onclick="location.href='qnaHome.do'">
		 <input type="button" value="목록보기" id="list" onclick="location.href='qnaList.do'">
	</div>
	</form>
</body>
<%@ include file="../footer.jsp" %> 