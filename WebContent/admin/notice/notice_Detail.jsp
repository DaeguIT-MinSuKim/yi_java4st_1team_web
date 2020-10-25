<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<script>
	document.title += ' - 공지사항 목록'
</script>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
	<h1 class="h3 mb-0 text-gray-800">공지사항 관리 - 공지사항 상세</h1>
</div>

<div>
	<label>${notice.noticeTitle}</label><br>
	<input type="text" value="${notice.noticeContent }">
</div>

<!-- Content Row -->
<div class="button">
	<input type="button" value="수정">
	<input type="button" value="삭제">
</div>


<%@ include file="../include/footer.jsp"%>
