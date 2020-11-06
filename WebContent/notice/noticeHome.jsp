<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../header.jsp"%>

<title>Insert title here</title>
<style>
a {
	text-decoration: none;
	color:black;
}

.qna-btn {background-color:white; border:1px solid gray; border-radius:2px; cursor:pointer}
</style>
<script>
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href = "noticeHome.do?nowPage=${paging.nowPage}&cntPerPage="
				+ sel;
	}
</script>
<form method="get" name="formm">
	<div class="qna_wrapper">
		<p style="text-align: center; font-size: 30px;">공지 사항</p>
		<div
			style="width: 1000px; margin: 0 auto; text-align: right; padding: 10px;">
			
			<div style="float: right;">
				<select class="custom-select custom-select-sm" name="condition"
					style="width: 80px;">
					<option <c:if test="${condition eq 'noticeTitle'}"> selected </c:if>  value="noticeTitle">제목</option>
					<option <c:if test="${condition eq 'noticeContent'}"> selected </c:if> value="noticeContent">내용</option>
				</select> <label> <input type="search" name="keyword" placeholder=""
					aria-controls="dataTable" style="width: 130px;">
				</label> <input type="submit" value="검색" class="qna-btn">
			</div>
			<br>
		</div>
		<table id="board" style="margin-bottom:50px">
			<tr>
				<th style="width: 100px; text-align: center;">번호</th>
				<th style="text-align: center;">제목</th>
				<th style="width: 100px; text-align: center;">작성일</th>
			</tr>
			<c:forEach items="${viewAll}" var="list">
				<tr>
					<td style="text-align: center;  font-weight:bold;">${list.noticeNo }</td>
					<td style="text-align:left;  font-weight:bold;"><a href="noticeDetail.do?no=${list.noticeNo}">${list.noticeTitle }</a></td>
					<td><fmt:parseDate value="${list.noticeRegDate}"
							pattern="yyyy-MM-dd'T'HH:mm" var="regDate" type="both" /> <fmt:formatDate
							value="${regDate}" pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:forEach>
		</table>

			<!-- 페이징 시작 -->

					<div style="width:100%; margin:0 auto; text-align:center; margin-top:20px;">
					
					
						<!-- << -->
						<c:if test="${paging.startPage != 1}">
							<div class="paging-line">
							<a href="noticeHome.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}">
								<i class="fas fa-angle-double-left"></i>
							</a>
							</div>
						</c:if>
						<c:if test="${paging.startPage == 1}">
							<div class="paging-line">
								<i class="fas fa-angle-double-left"></i>
							</div>
						</c:if>
						
						
						<!-- 이전페이지 -->
						<c:choose>
							<c:when test="${paging.nowPage != 1}">
								<div class="paging-line">
									<a href="noticeHome.do?nowPage=${paging.nowPage-1}&cntPerPage=${paging.cntPerPage}"><i class="fas fa-angle-left"></i></a>
								</div>
							</c:when>
							<c:when test="${paging.nowPage == 1}">
								<div class="paging-line">
									<i class="fas fa-angle-left"></i>
								</div>
							</c:when>
						
						</c:choose>
						
						<!-- 페이지 숫자 -->
						
						<c:forEach begin="${paging.startPage}" end="${paging.endPage }"
							var="p">
							<c:choose>
								<c:when test="${p == paging.nowPage }">
									<div class="paging-line" style="font-weight:bold">${p}</div>
								</c:when>
								<c:when test="${p != paging.nowPage }">
									<div class="paging-line">
									<a href="noticeHome.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}">
									${p}</a></div>
								</c:when>
							</c:choose>
						</c:forEach>
						
						
						
						<!-- 다음페이지 -->
						<c:choose>
							<c:when test="${paging.nowPage != paging.lastPage}">
								<div class="paging-line">
									<a href="noticeHome.do?nowPage=${paging.nowPage+1}&cntPerPage=${paging.cntPerPage}"><i class="fas fa-angle-right"></i></a>
								</div>
							</c:when>
							<c:when test="${paging.nowPage == paging.lastPage}">
								<div class="paging-line">
									<i class="fas fa-angle-right"></i>
								</div>	
							</c:when>
						
						</c:choose>	
						
						<!-- >> -->
						
					
						<c:if test="${paging.endPage != paging.lastPage }">
							<div class="paging-line">
							<a href="noticeHome.do?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">
							<i class="fas fa-angle-double-right"></i></a>
							</div>
						</c:if>
						<c:if test="${paging.endPage == paging.lastPage}">
							<div class="paging-line">
							<i class="fas fa-angle-double-right"></i>
							</div>
						</c:if>
					
					</div>
				</div>	
	
</form>
<%@ include file="../footer.jsp"%>
