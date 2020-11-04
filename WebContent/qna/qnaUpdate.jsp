<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script>
	function go_QnaUpdate() {
		var qtitle = $("#title").val();
		var qcontent = $("#content").val();
		var qno = $("#no").val();

		if (confirm("정말 수정하시겠습니까?")) {
			$.post("qnaUpdate.do", {
				content : qcontent,
				no : qno
			}, function() {
				location.href = 'qnaHome.do';
			});
		}
	}
</script>
<%@ include file="../header.jsp"%>



<h3 style="text-align: center;">Q & A 수정</h3>

<div class="content1-inner" style="text-align: center;">
	<p></p>
	<br> <input type="hidden" id="no" value="${qna.qnaNo }">
	<table class="outer">
		<tr class="tr" style="border-top: 1px solid black;">
			<th>제목</th>
			<td><input type="text" name="title" id="title"
				value="${qna.qnaTitle }"></td>
		</tr>
		<tr class="tr">
			<th>작성일</th>
			<td><fmt:parseDate value="${qna.qnaRegDate}"
					pattern="yyyy-MM-dd'T'HH:mm" var="regDate" type="both" /> <fmt:formatDate
					value="${regDate}" pattern="yyyy-MM-dd HH:mm" /></td>
		</tr>
		<c:if test="${qna.qnaContent != null}">
			<tr class="tr">
				<th>내용</th>
				<td style="padding-top: 100px;"><textarea name="content"
						id="content" cols="60" rows="10">${qna.qnaContent}</textarea></td>
			</tr>
		</c:if>



	</table>
	<c:if test="${ qna.qnaFile != null}">
		<img alt="" src="notice/upload/${qna.qnaFile}"
			style="width: 600px; height: 600px;">
	</c:if>

</div>
<div id="buttons" style="float: right">
	<input type="submit" value="수정하기" id="updateButton" class="button"
		onclick="go_QnaUpdate()"> <input type="reset" value="초기화"
		id="reset" class="button"> <input type="button" class="button"
		value="취소" id="home" onclick="location.href='qnaHome.do'">
</div>


<%@ include file="../footer.jsp"%>