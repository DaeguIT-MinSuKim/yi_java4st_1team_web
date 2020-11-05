<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ include file="../header.jsp" %>  
     <%@ include file="sub_menu.jsp" %>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
     <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<style>
.order a {background-color:white;  border-bottom:1px solid white;}
</style>
<body>


<div class="book_wrapper">
<h3 style="text-align:center; padding:20px; margin-bottom:50px;">나의 이용 내역</h3>

<table id="board">
	<tr>
		<th>번호</th> <th>주문날짜</th> <th>시술 정보</th> <th>디자이너</th> <th>총 금액</th>
	</tr>
	<c:choose>
		<c:when test="${message == -1}">
			 <tr><td colspan="5">주문건이 존재하지 않습니다.<td></tr>		
		 </c:when>
	</c:choose>
	
	<c:forEach var="orders" items="${list}" varStatus="status">
 	<tr onclick="location.href='guestOrderDetail.do?orderNo=${orders.ordersNo}'" style="cursor:pointer;" class="mypage_title">
 		<td class="book_index"> ${total - ((paging.nowPage-1) * cnt + status.index)}
 		<input type="hidden" value="${orders.ordersNo}" name="ordersNo">
 		</td>
 		<td class="book_date">
			<fmt:parseDate value="${orders.ordersDate}" pattern="yyyy-MM-dd'T'HH:mm" var="date" type="both" />
			<fmt:formatDate value="${date}" pattern="yyyy-MM-dd HH:mm" />
		</td>
		<td class="book_name">
		
			<c:if test="${orders.odList.size() == 1}">
				${orders.odList.get(0).hair.hairName}
			</c:if>
			<c:if test="${orders.odList.size() != 1}">
				${orders.odList.get(0).hair.hairName} 외  ${fn:length(orders.odList)-1}건
			</c:if>
		</td>
		<td>${orders.designer.deNickname }</td>
		<td class="book_price">
			<fmt:formatNumber value="${orders.ordersTotalPrice}" pattern="#,###" /> 
		</td>
	</tr>
	</c:forEach>
</table>
	</div>  


<!-- 페이징 시작 -->

					<div style="width:100%; text-align:center; display:inline-block; margin:0 auto;">
					<p>Total : ${total}</p>
					
						<!-- << -->
						<c:if test="${paging.startPage != 1}">
							<div class="paging-line">
							<a href="guestOrder.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}">
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
									<a href="guestOrder.do?nowPage=${paging.nowPage-1}&cntPerPage=${paging.cntPerPage}"><i class="fas fa-angle-left"></i></a>
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
									<a href="guestOrder.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}">
									${p}</a></div>
								</c:when>
							</c:choose>
						</c:forEach>
						
						
						
						<!-- 다음페이지 -->
						<c:choose>
							<c:when test="${paging.nowPage != paging.lastPage}">
								<div class="paging-line">
									<a href="guestOrder.do?nowPage=${paging.nowPage+1}&cntPerPage=${paging.cntPerPage}"><i class="fas fa-angle-right"></i></a>
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
							<a href="guestOrder.do?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">
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
