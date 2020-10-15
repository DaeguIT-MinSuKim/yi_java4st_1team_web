<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../header.jsp" %>  

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
		<h1>문의 사항 홈</h1>
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
					<td>
					<c:if test="${list.qnaSecret eq 'y'}">
						<img src="qna/images/secret.png" alt="" style="width: 20px; height: auto;" />
					</c:if>
					${list.qnaNo }</td>
					<td><a href="qnaConfirmPassword.do?no=${list.qnaNo}&secret=${list.qnaSecret}">${list.qnaTitle }</a></td>
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
	
	<div id="buttons" style="float: right">
		<input type="button" value="글쓰기" id="writeButton" onclick="location.href='qnaWrite.do'"> 
		<input type="button" value="문의 내역" id="list" onclick="location.href='qnaList.do'">
	</div>
</body>
<%@ include file="../footer.jsp" %>  