<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../header.jsp"%>
<style>
.qna-btn {background-color:white; border:1px solid gray; border-radius:2px; cursor:pointer}
a {
	text-decoration: none;
	color:black;
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
		<div style="width: 1000px; margin: 0 auto; text-align: right; padding: 10px;">
			
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
				</label> <input type="submit" value="검색" class="qna-btn">
			</div>
		</div>
		<table id="board">
			<tr style="text-align:center;">
				<th style="width: 10%;">번호</th>
				<th style="width: 47%;">제목</th>
				<th style="width: 15%;">작성자</th>
				<th style="width: 20%;">작성일</th>
				<th style="width: 8%;">답변 여부</th>
			</tr>
			<c:forEach items="${viewAll}" var="list">
				<c:if test="${list.qnaNotice eq 'y'}">
					<tr style="background-color: #f7f3ff;">
				</c:if>
				<c:if test="${list.qnaNotice eq 'n'}">
					<tr>
				</c:if>
				<td style="text-align:center">
					<c:if test="${list.qnaNotice eq 'y'}">
					<span style="font-weight:bold">공지</span>
					</c:if>
					<c:if test="${list.qnaNotice != 'y'}">
					${list.qnaNo }
				</c:if>
				</td>
				<td style="text-align:left;"><a
					href="qnaConfirmPassword.do?no=${list.qnaNo}&secret=${list.qnaSecret}">
						<c:if test="${list.qnaNotice eq 'y'}">
							　
						</c:if> <c:if test="${list.qnaSecret eq 'y'}">
							<i class="fas fa-lock" style="color:gray"></i>
						</c:if> ${list.qnaTitle }
				</a></td>
				<td><c:if test="${list.qnaNotice eq 'y' }">Hairrang</c:if>${list.guestId.guestId}</td>
				<td><fmt:parseDate value="${list.qnaRegDate}"
						pattern="yyyy-MM-dd'T'HH:mm" var="regDate" type="both" /> <fmt:formatDate
						value="${regDate}" pattern="yyyy-MM-dd HH:mm" /></td>

					<c:if test="${list.guestId.guestId != null}">
						<td><c:if test="${list.qnaResYn eq 'y'}">
							<span style="font-weight:bold">답변완료</span>
								<!-- <i class="fas fa-check"></i> -->
							</c:if>
							<c:if test="${list.qnaResYn eq 'n'}">미답변
								<!-- <i class="fas fa-check"></i> -->
							</c:if>
						</td>
					</c:if>
					<c:if test="${list.guestId.guestId == null}">
						<td></td>
					</c:if>
				
			</c:forEach>
		</table>
		<div class="qna_buttons" style="padding:10px">
			<input type="button"  style="float:left" value="내 문의 내역" id="list" onclick="location.href='guestQna.do'" class="qna-btn">
			<input type="button" value="글쓰기"  onclick="location.href='qnaWrite.do'" class="qna-btn"> 
		</div>

	
	<!-- 페이징 시작 -->

					<div style="width:100%; margin:0 auto; text-align:center;">
					
						<!-- << -->
						<c:if test="${paging.startPage != 1}">
							<div class="paging-line">
							<a href="guestBook.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}">
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
									<a href="guestBook.do?nowPage=${paging.nowPage-1}&cntPerPage=${paging.cntPerPage}"><i class="fas fa-angle-left"></i></a>
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
									<a href="guestBook.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}">
									${p}</a></div>
								</c:when>
							</c:choose>
						</c:forEach>
						
						
						
						<!-- 다음페이지 -->
						<c:choose>
							<c:when test="${paging.nowPage != paging.lastPage}">
								<div class="paging-line">
									<a href="guestBook.do?nowPage=${paging.nowPage+1}&cntPerPage=${paging.cntPerPage}"><i class="fas fa-angle-right"></i></a>
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
							<a href="guestBook.do?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">
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
