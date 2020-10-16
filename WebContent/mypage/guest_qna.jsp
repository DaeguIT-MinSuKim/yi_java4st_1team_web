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
		<p style="text-align: center; font-size: 30px;">문의 내역</p>
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
					<td class="qna_resYn">${qna.qnaResYn}</td>
				</tr>
			</c:forEach>
		</table>
		<div class="paging">
			<c:if test="${paging.startPage != 1}">
				<a href="guestQna.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}"><i class="xi-angle-left"></i></a>	
			</c:if>
			
			&nbsp;&nbsp;
			<c:forEach begin="${paging.startPage}" end="${paging.endPage }"
				var="p">
				<c:choose>
					<c:when test="${p == paging.nowPage }">
						<b>${p}</b>
					</c:when>
					<c:when test="${p != paging.nowPage }">
						<a href="guestQna.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
					</c:when>
				</c:choose>
			</c:forEach>
			&nbsp;&nbsp;
		
			<c:if test="${paging.endPage != paging.lastPage }">
				<a href="guestQna.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}"><i class="xi-angle-right"></i></a>
			</c:if>
			
		</div>
	</div>
</body>

<%@ include file="../footer.jsp" %>  