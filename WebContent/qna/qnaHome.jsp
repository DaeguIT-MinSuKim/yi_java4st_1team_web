<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>문의사항</h2>
	<table id="qnatList">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<!-- <th>등록일</th> -->
			<th>답변 여부</th>
		</tr>
		<c:forEach items="${qnaList}" var="qna">
			<tr>
				<td>${qna.qnaNo}</td>
				<td><a href="qnaView.do?no=${qna.qnaNo}"> ${qna.qnaTitle}</a></td>
				<%-- <td><fmt:formatDate value="${qna.qnaRegDate}" type="date" /></td> --%>
				<td><c:choose>
						<c:when test="${qna.qnaResYn eq 'n' }"> no </c:when>
						<c:when test="${qna.qnaResYn eq 'y' }"> yes </c:when>
					</c:choose></td>
			</tr>
		</c:forEach>
	</table>
	<h2>공지사항</h2>
	<table id="noticeList">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<!-- <th>등록일</th> -->
			<!-- <th>답변 여부</th> -->
		</tr>
		<c:forEach items="${noticeList}" var="notice">
			<tr>
				<td>${notice.qnaNo}</td>
				<td><a href="qnaView.do?no=${notice.qnaNo}">
						${notice.qnaTitle}</a></td>
				<%-- <td><fmt:formatDate value="${qna.qnaRegDate}" type="date" /></td> --%>
			</tr>
		</c:forEach>
	</table>
	<a href="qnaWrite.do">문의하기</a>
	<a href="qnaList.do">문의내역</a>
>>>>>>> branch 'master' of https://github.com/DaeguIT-MinSuKim/yi_java4st_1team_web
</body>
</html>