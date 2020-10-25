<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp"%>
<body>
	<h1>공지 상세</h1>
	<br>
	<label>${notice.noticeTitle }</label>
	<hr>
	<br>
	<input type="text" readonly value="${notice.noticeContent}">
	<br>

	<div style="display: block; text-align: center;">
		<c:forEach items="${list }" var="side">
			<ul>
				<li><a href="noticeDetail.do?no=${notice.noticeNo }">
						<div>
							<p>
								<span>${side.noticeTitle }</span>
						</div>
				</a></li>
			</ul>
		</c:forEach>
	</div>


	<input style="float: right;" type="button" value="홈으로"
		onclick="location.href='noticeHome.do'">
</body>
<%@ include file="../footer.jsp"%>
