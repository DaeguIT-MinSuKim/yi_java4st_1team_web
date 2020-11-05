<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%@ include file="../header.jsp" %> 
    <%@ include file="sub_menu.jsp" %>
<style>
.book a {background-color:white;  border-bottom:1px solid white;}
.book-btn {border: 1px solid gray;background-color:#fff; cursor:pointer; font-size:15px;}
</style>
<body>
<div class="book_wrapper">
<h3 style="text-align:center; padding:20px; margin-bottom:50px;">MY RESERVATION</h3>
<div class="tcenter" style="float:right; padding:10px;">
	<input type="button" value="전체보기" onclick="location.href='guestBook.do'" class="book-btn">
	<input type="button" value="예약완료" onclick="location.href='status1.do'" class="book-btn">
	<input type="button" value="예약취소" onclick="location.href='status0.do'" class="book-btn">
</div>
<table id="board">
	<tr>
		<th>번호</th> <th>이용날짜</th> <th>시술 정보</th> <th>총 금액</th> <th>예약상태</th> <th>예약등록일</th> 
	</tr>
	<c:choose>
		<c:when test="${message == -1}">
			 <tr><td colspan="6">예약취소건이 존재하지 않습니다.<td></tr>		
		 </c:when>
	</c:choose>
	
	<c:forEach var="booking" items="${list}" varStatus="status">
 	<tr onclick="location.href='guestBookDetail.do?bookNo=${booking.bookNo}'" style="cursor:pointer;" class="mypage_title">
 		<td class="book_index">${total - ((paging.nowPage-1) * cnt + status.index)} 
 		<input type="hidden" value="${booking.bookNo}" name="bookNo">
 		</td>
 		<td class="book_date">
			<fmt:parseDate value="${booking.bookDate}" pattern="yyyy-MM-dd'T'HH:mm" var="bookDate" type="both" />
			<fmt:formatDate value="${bookDate}" pattern="yyyy-MM-dd HH:mm" />
		</td>
		<td class="book_name">
			<c:if test="${booking.hairList.size() == 1}">
				${booking.hairList.get(0).hair.hairName}
			</c:if>
			<c:if test="${booking.hairList.size() != 1}">
			${booking.hairList.get(0).hair.hairName} 외  ${fn:length(booking.hairList)-1}건
			</c:if>
		</td>
		<td class="book_price">
			<%-- <c:set var="pSum" value="0" />
			<c:forEach items="${booking.hairList}" var="h">
				<c:set var="pSum" value="${pSum }+${h.hair.hairPrice }*${h.quantity }" />
			</c:forEach>
			${pSum } --%>
			<%-- <fmt:formatNumber value="${pSum}" type="currency"/> --%>
			<fmt:formatNumber value="${pp.get(status.index)}" pattern="#,###" />
		</td>
		<td class="book_status">${booking.bookStatusStr}</td>
		<td class="book_reg">
			<fmt:parseDate value="${booking.bookRegDate}" pattern="yyyy-MM-dd'T'HH:mm" var="bookReg" type="both" />
			<fmt:formatDate value="${bookReg}" pattern="yyyy-MM-dd HH:mm" />
		</td>
	</tr>
	</c:forEach>
</table>

					<div style="width:100%; text-align:center; display:inline-block; margin:0 auto;">
					<p>Total : ${total}</p>
					
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
</body>
<%@ include file="../footer.jsp" %>  