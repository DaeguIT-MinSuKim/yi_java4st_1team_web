<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ include file="../header.jsp" %>  
    <%@ include file="sub_menu.jsp" %>
<style>
.qna a {background-color:white;  border-bottom:1px solid white;}
</style> 
<script>
	/* function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href="guestBook.do?nowPage=${paging.nowPage}&cntPerPage="+sel;
	} */
</script>

<body>
	<div class="book_wrapper">
		<h3 style="text-align:center; margin-bottom:68px;">나의 문의 내역</h3>
		<table id="board">
			<tr class=>
				<th>번호</th>
				<!-- <th>qna번호</th> -->
				<th>제목</th>
				<th>등록일</th>
				<th>답변여부</th>
			</tr>
			<c:forEach items="${list}" var="qna" varStatus="status">
				<tr onclick="location.href='guestQnaDetail.do'" class="mypage_title">
					<td class="qna_index">${total - ((paging.nowPage-1) * cnt + status.index)}</td>
					<%-- <td>${qna.qnaNo }</td> --%>
					<td class="qna_title">${qna.qnaTitle}</td>
					<td class="qna_date"><fmt:parseDate value="${qna.qnaRegDate}"
							pattern="yyyy-MM-dd'T'HH:mm" var="qnaRegDate" type="both" /> <fmt:formatDate
							value="${qnaRegDate}" pattern="yyyy-MM-dd HH:mm" /></td>
					<td class="qna_resYn">
						<c:if test="${qna.qnaResYn == 'y'}">답변완료</c:if>
						<c:if test="${qna.qnaResYn == 'n'}">미답변</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
		
		
		<!-- 페이징 -->
					<div style="width:100%; text-align:center; display:inline-block; margin:0 auto;">
					<p>Total : ${total}</p>
					
						<!-- << -->
						<c:if test="${paging.startPage != 1}">
							<div class="paging-line">
							<a href="guestQna.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}">
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
									<a href="guestQna.do?nowPage=${paging.nowPage-1}&cntPerPage=${paging.cntPerPage}"><i class="fas fa-angle-left"></i></a>
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
									<a href="guestQna.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}">
									${p}</a></div>
								</c:when>
							</c:choose>
						</c:forEach>
						
						
						
						<!-- 다음페이지 -->
						<c:choose>
							<c:when test="${paging.nowPage != paging.lastPage}">
								<div class="paging-line">
									<a href="guestQna.do?nowPage=${paging.nowPage+1}&cntPerPage=${paging.cntPerPage}"><i class="fas fa-angle-right"></i></a>
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
							<a href="guestQna.do?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">
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
</body>

<%@ include file="../footer.jsp" %>  