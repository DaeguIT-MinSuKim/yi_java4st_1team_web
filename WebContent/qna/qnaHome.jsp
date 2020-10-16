<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../header.jsp" %>  

<title>Insert title here</title>
<style>
	
</style>
<script>
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href="qnaHome.do?nowPage=${paging.nowPage}&cntPerPage="+sel;
	}
</script>
</head>
<body>
	
	<div class="qna_wrapper">
		<p style="text-align:center; font-size:30px;">문의 사항</p>
		<div style="width:1000px; margin:0 auto; text-align:right; padding:10px;">
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
		<table id="board">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>내용</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>답변</th>
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
					<td>${list.guestId.guestName}</td>
					<td>
						<fmt:parseDate value="${list.qnaRegDate}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate" type="both" />
						<fmt:formatDate value="${regDate}" pattern="yyyy-MM-dd HH:mm" />
					</td>
					<td>${list.qnaResYn }</td>
				</tr>
			</c:forEach>
		</table>

		<div class="paging">
			<c:if test="${paging.startPage != 1}">
				<a href="qnaHome.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}"><i class="xi-angle-left"></i></a>	
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
				<a href="qnaHome.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}"><i class="xi-angle-right"></i></a>
			</c:if>	
		</div>
	</div>
	
	<div class="qna_buttons">
		<input type="button" value="글쓰기" id="writeButton" onclick="location.href='qnaWrite.do'"> 
		<input type="button" value="문의 내역" id="list" onclick="location.href='qnaList.do'">
	</div>
</body>
<%@ include file="../footer.jsp" %>  