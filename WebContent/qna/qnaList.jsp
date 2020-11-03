<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<style>
p {
	margin: 0 0 20px;
	line-height: 1.5;
}

.about_main {
	margin-top: 50px;
	text-align: center;
	background: #ffffff;
}

.content1, .content2 {
	display: none;
	padding: 20px 0 0;
	border-top: 1px solid #ddd;
}

.content1-inner {
	width: 800px;
	margin: 0 auto;
	text-align: left;
}

.text {
	width: 500px;
	text-align: left;
}

button {
	width: 130px;
	height: 50px;
	color: black;
	border: none;
	font-size: 15px;
	font-weight: bold;
	float: right;
	margin: 5px;
	width: 200px;
	background: white;
	border: 1px solid #777;
}

.outer {
	width: 800px;
}

.tr {
	padding: 50px;
	border-bottom: 1px solid black;
}

* td {
	padding-top: 20px;
	padding-bottom: 20px;
}

tr td:first-child {
	width: 60px;
}

tr td:nth-child(2) {
	text-align: left;
}

.button {
	border: 3px solid gray;
	width: 100px;
	padding: 10px;
	margin: 0 auto;
	border-radius: 10px;
	color: black;
	font-weight: bold;
	cursor: pointer;
}
</style>

<h3 style="text-align: center;">내 문의내역</h3>

<div class="content1-inner" style="text-align: center;">
	<p></p>
	<br>
	<table class="outer">

		<tr class="tr" style="border-top: 1px solid black;">
			<th>번호</th>
			<th>제목</th>
			<th>답변 여부</th>
		</tr>

		<c:forEach items="${qnaList}" var="qna">
			<tr class="tr">
				<td>${qna.qnaNo}</td>
				<td><a href="qnaDetail.do?no=${qna.qnaNo}"> ${qna.qnaTitle}</a></td>
				<%-- <td><fmt:formatDate value="${qna.qnaRegDate}" type="date" /></td> --%>
				<td><c:choose>
						<c:when test="${qna.qnaResYn eq 'n' }"> no </c:when>
						<c:when test="${qna.qnaResYn eq 'y' }"> yes </c:when>
					</c:choose></td>
			</tr>
		</c:forEach>
	</table>
</div>
<input style="float: right;" type="button" value="홈으로" class="button"
	onclick="location.href='noticeHome.do'">

<%@ include file="../footer.jsp"%>







<%@ include file="../footer.jsp"%>
