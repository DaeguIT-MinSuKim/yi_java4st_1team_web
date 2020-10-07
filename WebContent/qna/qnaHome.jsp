<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	h2 {
		text-align: center;
	}
	table {
		width: 100%;
	}
	#outter {
		display: block;
		width: 60%;
		margin: auto;
	}
	a {
		text-decoration: none;
	}
</style>
<script>
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href="qnaHome.do?nowPage=${paging.nowPage}&cntPerPage="+sel;
	}
</script>
</head>
<body>
	<%-- <h2>문의사항</h2>
	<table id="qnatList">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<!-- <th>등록일</th> -->
			<th>답변 여부</th>
		</tr>
		<c:forEach items="${qnaList}" var="qna">
			<tr>
				<td>${qna.qnaNo}</td>
				<td><a href="qnaDetail.do?no=${qna.qnaNo}"> ${qna.qnaTitle}</a></td>
				<td><fmt:formatDate value="${qna.qnaRegDate}" type="date" /></td>
				<td><c:choose>
						<c:when test="${qna.qnaResYn eq 'n' }"> no </c:when>
						<c:when test="${qna.qnaResYn eq 'y' }"> yes </c:when>
					</c:choose></td>
			</tr>
		</c:forEach>
	</table>
	<h2>공지사항</h2>
	<table id="noticeList">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<!-- <th>등록일</th> -->
			<!-- <th>답변 여부</th> -->
		</tr>
		<c:forEach items="${noticeList}" var="notice">
			<tr>
				<td>${notice.qnaNo}</td>
				<td><a href="qnaView.do?no=${notice.qnaNo}">
						${notice.qnaTitle}</a></td>
				<td><fmt:formatDate value="${qna.qnaRegDate}" type="date" /></td>
			</tr>
		</c:forEach>
	</table>
	<a href="qnaWrite.do">문의하기</a>
	<a href="qnaList.do">문의내역</a> --%>
	
		<hr>
		<h1>여기서부트는 페이징~</h1>
	<div id="outter">
		<div style="float: right;">
			<select id="cntPerPage" name="sel" onchange="selChange()">
			<option value="5"
				<c:if test="${paging.cntPerPage == 5}">selected</c:if>>5줄 보기</option>
			<option value="10"
				<c:if test="${paging.cntPerPage == 10}">selected</c:if>>10줄 보기</option>
			<option value="15"
				<c:if test="${paging.cntPerPage == 15}">selected</c:if>>15줄 보기</option>
			<option value="20"
				<c:if test="${paging.cntPerPage == 20}">selected</c:if>>20줄 보기</option>
		</select>
		</div>
		<table border="1">
			<tr>
				<td>no</td>
				<td>제목</td>
				<td>내용</td>
				<td>답변</td>
			</tr>
			<c:forEach items="${viewAll}" var="list">
				<tr>
					<td>${list.qnaNo }</td>
					<td>${list.qnaTitle }</td>
					<td>${list.qnaContent }</td>
					<td>${list.qnaResYn }</td>
				</tr>
			</c:forEach>
		</table>

		<div style="display: block; text-align: center;">
			<c:if test="${paging.startPage != 1}">
				<a href="qnaHome.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}">&lt;</a>	
			</c:if>
			<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
				<c:choose>
					<c:when test="${p == paging.nowPage }">
						<b>${p }</b>
					</c:when>
					<c:when test="${p != paging.nowPage }">
						<a href="qnaHome.do?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
					</c:when>
				</c:choose>
			</c:forEach>		
			<c:if test="${paging.endPage != paging.lastPage }">
				<a href="qnaHome.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&rt;</a>
			</c:if>	
		</div>
	</div>
</body>
</html>