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
	border:3px solid gray; 
	width:100px; 
	padding:10px; 
	margin:0 auto; 
	border-radius:10px; 
	color: black; 
	font-weight:bold;
	cursor:pointer;
}
</style>

<h3 style="text-align: center;">Notice</h3>

<div class="content1-inner" style="text-align: center;">
	<p></p>
	<br>
	<table class="outer">

		<tr class="tr" style="border-top: 1px solid black;">
			<th>제목</th>
			<td>${notice.noticeTitle }</td>
		</tr>
		<tr class="tr">
			<th>작성일</th>
			<td>${notice.noticeRegDate }</td>
		</tr>
		<tr class="tr">
			<th>내용</th>
			<td >${notice.noticeContent }</td>

		</tr>
		<%-- <c:if test="${ notice.noticeFile != null}">
			<tr class="tr">
				<td style="text-align: center; bor"><img alt="" src="notice/setload/${notice.noticeFile}"></td>
			</tr>
		</c:if> --%>

	</table>
	<c:if test="${ notice.noticeFile != null}">
		<img alt="" src="notice/setload/${notice.noticeFile}"
			style="width: 600px; height: 600px;">
	</c:if>
</div>
<input style="float: right;" type="button" value="홈으로" class="button"
	onclick="location.href='noticeHome.do'">

<%@ include file="../footer.jsp"%>
