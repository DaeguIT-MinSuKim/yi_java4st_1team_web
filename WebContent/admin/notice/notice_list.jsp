<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<script>
	document.title += ' - 공지사항 목록'

	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href = "qnaHome.do?nowPage=${paging.nowPage}&cntPerPage="
				+ sel;
	}
</script>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
	<h1 class="h3 mb-0 text-gray-800">공지사항 관리 - 공지사항 목록</h1>
</div>

<!-- Content Row -->
<div class="row">
	<p style="text-align: center; font-size: 30px;">문의 사항</p>
	<div
		style="width: 1000px; margin: 0 auto; text-align: right; padding: 10px;">
		<input type="button" value="작성">
		<select id="cntPerPage" name="sel" onchange="selChange()">
			<option value="5"
				<c:if test="${paging.cntPerPage == 5}">selected</c:if>>5줄
				보기</option>
			<option value="10"
				<c:if test="${paging.cntPerPage == 10}">selected</c:if>>10줄
				보기</option>
			<option value="15"
				<c:if test="${paging.cntPerPage == 15}">selected</c:if>>15줄
				보기</option>
			<option value="20"
				<c:if test="${paging.cntPerPage == 20}">selected</c:if>>20줄
				보기</option>
		</select>
	</div>
	<table id="board">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>내용</th>
		</tr>
		<c:forEach items="${viewAll}" var="list">
			<tr>
				<td>${list.noticeNo }</td>
				<td><a href="/admin/noticeDetail.do?no=${list.noticeNo}">${list.noticeTitle }</a></td>
				<td>${list.noticeContent }</td>
			</tr>
		</c:forEach>
	</table>


	<div>
		<input type="text"> <input type="button" value="검색">
	</div>

	<div class="paging">
		<c:if test="${paging.startPage != 1}">
			<a
				href="/admin/noticeList.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}"><i
				class="xi-angle-left"></i></a>
		</c:if>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }"
			var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a
						href="/admin/noticeList.do?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.endPage != paging.lastPage }">
			<a
				href="/admin/noticeList.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}"><i
				class="xi-angle-right"></i></a>
		</c:if>
	</div>
</div>

<%@ include file="../include/footer.jsp"%>
