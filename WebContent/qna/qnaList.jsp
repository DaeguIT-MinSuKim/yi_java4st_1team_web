<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table id="cartList">
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
						<c:when test="${qna.repYn eq 'n' }"> no </c:when>
						<c:when test="${qna.repYn eq 'y' }"> yes </c:when>
					</c:choose></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>