<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ include file="../header.jsp" %>  
     <%@ include file="sub_menu.jsp" %>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<style>
.book a {color: black; padding:30px 60px; border: 1px solid #ddd; border-top: 2px solid gray; border-bottom: 1px solid #ffffff;}
</style>     
<script>
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href="guestBook.do?nowPage=${paging.nowPage}&cntPerPage="+sel;
	}
</script>
<body>
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
<div class="book_wrapper">
<p style="text-align:center; font-size:30px;">예약 내역</p>
<table id="board">
		<tr>
			<th>번호</th> <th>(확인용)예약번호</th> <th>예약일</th> <th>시술명</th> <th>총 금액</th> <th>예약상태</th> <th>예약등록일</th> <th>상세내역</th>
		</tr>
		<c:forEach items="${viewAll}" var="booking">
			<tr>
				<td>${booking.rownum}</td>
				<td>${booking.bookNo}</td>
				<td>
					<fmt:parseDate value="${booking.bookDate}" pattern="yyyy-MM-dd'T'HH:mm" var="bookDate" type="both" />
					<fmt:formatDate value="${bookDate}" pattern="yyyy-MM-dd HH:mm" />
				</td>
				<td>${booking.hair.hairName}</td>
				<td>${booking.hair.hairPrice}</td>
				<td>${booking.bookStatus}</td>
				<td>
				<fmt:parseDate value="${booking.bookRegDate}" pattern="yyyy-MM-dd'T'HH:mm" var="bookReg" type="both" />
				<fmt:formatDate value="${bookReg}" pattern="yyyy-MM-dd HH:mm" />
			</td>
		<td>버튼넣기</td>
		</tr>
		</c:forEach>
		
		</table>

		<div style="display: block; text-align: center;">
			<c:if test="${paging.startPage != 1}">
				<a href="guestBook.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}">&lt;</a>	
			</c:if>
			<a href="guestBook.do?nowPage=${paging.nowPage -1}&cntPerPage=${paging.cntPerPage}">이전</a>
			<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
				<c:choose>
					<c:when test="${p == paging.nowPage }">
						<b>${p}</b>
					</c:when>
					<c:when test="${p != paging.nowPage }">
						<a href="guestBook.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
					</c:when>
				</c:choose>
			</c:forEach>
			<a href="guestBook.do?nowPage=${paging.nowPage + 1}&cntPerPage=${paging.cntPerPage}">다음</a>
			<c:if test="${paging.endPage != paging.lastPage }">
				<a href="guestBook.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&rt;</a>
			</c:if>
		</div>
	</div>
	</div>
	
</body>


<%@ include file="../footer.jsp" %>  