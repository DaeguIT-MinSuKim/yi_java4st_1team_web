<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ include file="../header.jsp" %>  

<body>
	<!-- 준호 이벤트 넣는법 -->
	<!-- <a href="#juno"><span class="thum"><img
			src="/upload/news/202010/fec989d501b34be6b0c77bf2f030f73c.jpg" alt=""></span>
		<div class="cnt">
			<p class="subj">
				<span>준오헤어 2020 F/W 컬러 트렌드 '프렌치 준브레(FRENCH JUNBRE)'</span>
			</p>
			<p class="cate">NEWS</p>
		</div></a> -->
	<h1>이벤트</h1>


	<div style="display: block; text-align: center;">
		<c:forEach items="${list }" var="event">
			<ul>
				<li><a href="eventDetail.do?eno=${event.eventNo }"><span><img
							src="${event.eventPic }" alt=""></span>
						<div>
							<p>
								<span>${event.eventName }</span>
						</div></a></li>
			</ul>
		</c:forEach>
	</div>
	console.log(왜안돼);
</body>
<%@ include file="../footer.jsp" %>   