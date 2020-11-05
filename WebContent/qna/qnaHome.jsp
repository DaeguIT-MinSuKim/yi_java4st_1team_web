<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../header.jsp"%>
<style>
.button {
	border: 1px solid gray;
	width: 100px;
	padding: 10px;
	margin: 0 auto;
	color: black;
	font-weight: bold;
}

a {
	text-decoration: none;
}

tr * {
	text-align: left;
}
</style>
<title>Insert title here</title>
<style>
</style>
<script>
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href = "qnaHome.do?nowPage=${paging.nowPage}&cntPerPage="
				+ sel;
	}
</script>
<form method="get" name="formm">
	<div class="qna_wrapper">
		<p style="text-align: center; font-size: 30px;">문의 사항</p>
		<div
			style="width: 1000px; margin: 0 auto; text-align: right; padding: 10px;">
			<select id="cntPerPage" name="sel" onchange="selChange()"
				style="float: left;">
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
			<div id="dataTable_filter" class="dataTables_filter ">
				<select name="condition" style="width: 80px;">
					<option <c:if test="${condition eq 'qnaTitle'}"> selected </c:if>
						value="qnaTitle">제목</option>
					<option <c:if test="${condition eq 'qnaContent'}"> selected </c:if>
						value="qnaContent">내용</option>
					<option <c:if test="${condition eq 'qnaWriter'}"> selected </c:if>
						value="qnaWriter">작성자</option>
				</select> <label> <input type="search" name="keyword"
					class="form-control form-control-sm" placeholder=""
					aria-controls="dataTable" style="width: 130px;">
				</label> <input type="submit" value="검색">
			</div>
		</div>
		<table id="board">
			<tr>
				<th style="width: 15%;">번호</th>
				<th style="width: 40%;">제목</th>
				<th style="width: 20%;">작성자</th>
				<th style="width: 20%;">작성일</th>
				<th style="width: 5%;">답변</th>
			</tr>
			<c:forEach items="${viewAll}" var="list">
				<c:if test="${list.qnaNotice eq 'y'}">
					<tr style="background-color: #BCBCD9">
				</c:if>
				<c:if test="${list.qnaNotice eq 'n'}">
					<tr>
				</c:if>
				<td>${list.qnaNo }</td>
				<td><a
					href="qnaConfirmPassword.do?no=${list.qnaNo}&secret=${list.qnaSecret}">
						<c:if test="${list.qnaNotice eq 'y'}">
							<i class="fas fa-flag"></i>
						</c:if> <c:if test="${list.qnaSecret eq 'y'}">
							<i class="fas fa-lock"></i>
						</c:if> ${list.qnaTitle }
				</a></td>
				<td><c:if test="${list.qnaNotice eq 'y' }">Hairrang</c:if>${list.guestId.guestId}</td>
				<td><fmt:parseDate value="${list.qnaRegDate}"
						pattern="yyyy-MM-dd'T'HH:mm" var="regDate" type="both" /> <fmt:formatDate
						value="${regDate}" pattern="yyyy-MM-dd HH:mm" /></td>

				<c:if test="${list.guestId.guestId != null}">
					<td><c:if test="${list.qnaResYn eq 'y'}">
							<i class="fas fa-check" style="color: #09D345;"></i>
						</c:if></td>
				</c:if>
				<c:if test="${list.guestId.guestId == null}">
					<td></td>
				</c:if>
				</tr>
			</c:forEach>
		</table>

		<div class="paging" style="text-align: center;">
			<c:if test="${paging.startPage != 1}">
				<a
					href="qnaHome.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}"><i
					class="xi-angle-left"></i></a>
			</c:if>
			<c:forEach begin="${paging.startPage }" end="${paging.endPage }"
				var="p">
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
				<a
					href="qnaHome.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}"><i
					class="xi-angle-right"></i></a>
			</c:if>
		</div>
	</div>

	<div class="qna_buttons">
		<input type="button" value="글쓰기" id="writeButton" class="button"
			onclick="location.href='qnaWrite.do'"> <input type="button"
			class="button" value="문의 내역" id="list"
			onclick="location.href='qnaList.do'">
	</div>
</form>
<%@ include file="../footer.jsp"%>
