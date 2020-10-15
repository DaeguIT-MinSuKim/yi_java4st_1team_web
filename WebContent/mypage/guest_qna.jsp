<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ include file="../header.jsp" %>  
    <%@ include file="sub_menu.jsp" %>
<style>
.qna a {color: black; padding:30px 60px; border: 1px solid #ddd; border-top: 2px solid gray; border-bottom: 1px solid #ffffff;}   
</style> 
<body>
<div class="book_wrapper">
<p style="text-align:center; font-size:30px;">문의 내역</p>
<table id="board">
<tr>
	<th>번호</th> <th>제목</th> <th>등록일</th> <th>답변여부</th>
</tr>
<c:forEach items="${list}" var="qna" varStatus="status">
<tr>
	<!-- 일단 카운트만  -->
	<td>${status.count}</td>
	<td><a href="guestQnaDetail.do">${qna.qnaTitle}</a></td>
	<td><fmt:parseDate value="${qna.qnaRegDate}" pattern="yyyy-MM-dd'T'HH:mm" var="qnaRegDate" type="both" />
		<fmt:formatDate value="${qnaRegDate}" pattern="yyyy-MM-dd HH:mm" />
	</td>
	<td>${qna.qnaResYn}</td>
	
</tr>
</c:forEach>
</table>
</div>
</body>

<%@ include file="../footer.jsp" %>  