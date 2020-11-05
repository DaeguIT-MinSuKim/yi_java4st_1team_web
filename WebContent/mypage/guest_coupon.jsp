<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ include file="../header.jsp" %>  
     <%@ include file="sub_menu.jsp" %>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<style>
.coupon a {background-color:white;  border-bottom:1px solid white;}
.book-btn {border: 1px solid gray;background-color:#fff; cursor:pointer; font-size:15px;}
</style>   
<body>
<div class="book_wrapper">
<h3 style="text-align:center; padding:20px; margin-bottom:50px;">MY COUPON</h3>
<div style="float:right; padding:10px;">
	<input type="button" value="전체보기" onclick="location.href='guestCoupon.do'" class="book-btn">
	<input type="button" value="기간만료" onclick="location.href='guestCoupon.do?nowPage=1&status=e'" class="book-btn">
</div>
<table id="board">
		<tr>
			 <th>번호</th> <th>쿠폰명</th> <th>할인율</th> <th>쿠폰 기간</th> <th>사용여부</th> <th>이벤트상태</th>
		</tr>
		<c:forEach items="${list}" var="coupon" varStatus="status">
			<tr>
					
				<td class="book_index">${total - ((paging.nowPage-1) * cnt + status.index)}</td>
				<%-- <td>${coupon.couponId}</td>
				<td>${coupon.event.eventNo}</td> --%>
				<td style="width:200px">${coupon.event.eventName}</td>
				<td style="width:50px"><fmt:parseNumber value="${coupon.event.eventSaleRate * 100}" integerOnly="true"/>%</td>
				<td style="width:200px;">${coupon.event.eventStart} ~ ${coupon.event.eventEnd}</td>
				<td style="width:50px">
					<c:if test="${coupon.usedYn == 'n'}"><span style="font-weight:bold">사용가능</span></c:if>
					<c:if test="${coupon.usedYn == 'y'}">사용완료</c:if>
					<c:if test="${coupon.usedYn == 'e'}"><span style="color:gray">미사용만료</span></c:if>
				</td>
				<td style="width:50px">
				<c:if test="${coupon.event.eventStatus == 's'}">진행중</c:if>
				<c:if test="${coupon.event.eventStatus == 'e'}"><span style="color:gray">종료</span></c:if>
			</tr>
		</c:forEach>
		</table>
	
	<!-- 페이징 -->
					<div style="width:100%; text-align:center; display:inline-block; margin:0 auto;">
					<p>Total : ${total}</p>
					
						<!-- << -->
						<c:if test="${paging.startPage != 1}">
							<div class="paging-line">
							<a href="guestCoupon.do?nowPage=${paging.startPage -1}&status=${status}">
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
									<a href="guestCoupon.do?nowPage=${paging.nowPage-1}&status=${status}"><i class="fas fa-angle-left"></i></a>
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
									<a href="guestCoupon.do?nowPage=${p}&status=${status}">
									${p}</a></div>
								</c:when>
							</c:choose>
						</c:forEach>
						
						
						
						<!-- 다음페이지 -->
						<c:choose>
							<c:when test="${paging.nowPage != paging.lastPage}">
								<div class="paging-line">
									<a href="guestCoupon.do?nowPage=${paging.nowPage+1}"><i class="fas fa-angle-right"></i></a>
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
							<a href="guestCoupon.do?nowPage=${paging.endPage+1}">
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