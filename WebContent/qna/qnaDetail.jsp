<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	border-bottom: 1px solid #EEEEEE;
}

* td {
	padding-top: 10px;
	padding-bottom: 10px;
}

tr td:first-child {
	width: 60px;
}

tr td:nth-child(2) {
	text-align: left;
}

.button {
	border: 1px solid gray;
	width: 100px;
	padding: 5px;
	margin: 0 auto;
	color: black;
	font-weight: bold;
}

.resCard {
	width: 99%;
	background-color: #F6F6F6;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
}
</style>

<script>
	function go_delQna(no) {
		var no = document.getElementById('no').value;
		
		if (confirm("정말 삭제하시겠습니까?")) {
			$.ajax({
				type : 'get',
				url : 'qnaDelete.do',
				data : {
					no : no
				},
				async : false,
				success : function(){
					location.href='qnaHome.do';
					},
				error : function() {
					alert('삭제할 문의을 선택하세요');
				}
			});
		} else {
			return;
		}
	}
</script>
<h3 style="text-align: center;">Q & A</h3>
<form name="formm">
	<div class="content1-inner" style="text-align: center;">
		<p></p>
		<br> <input type="hidden" id="no" value="${qna.qnaNo }">
		<table class="outer">

			<tr class="tr" style="border-top: 1px solid black;">
				<th style="width: 15%;">번호</th>
				<td>${qna.qnaNo }</td>
			</tr>
			<tr class="tr">
				<th>제목</th>
				<td>${qna.qnaTitle }</td>
			</tr>
			<tr class="tr">
				<th>작성일</th>
				<td><fmt:parseDate value="${qna.qnaRegDate}"
						pattern="yyyy-MM-dd'T'HH:mm" var="regDate" type="both" /> <fmt:formatDate
						value="${regDate}" pattern="yyyy-MM-dd" /></td>
			</tr>
			<c:if test="${qna.qnaContent != null}">
				<tr class="tr" style="border-bottom: 1px solid black;">
					<th>내용</th>
					<td>${qna.qnaContent }</td>
				</tr>
			</c:if>



		</table>
		<br>
		<c:if test="${ qna.qnaFile != null}">
			<c:if test="${qna.qnaNotice eq 'y' }">
				<img alt="" src="notice/setload/${qna.qnaFile}"
					style="max-width: 100%; height: auto;">
			</c:if>
			<c:if test="${qna.qnaNotice eq 'n' }">
				<img alt="" src="qna/upload/${qna.qnaFile}"
					style="max-width: 100%; height: auto;">
			</c:if>
		</c:if>


		<!-- 답변 -->
		<c:if test="${qna.qnaResYn eq 'y'}">

		
			<p></p>
			<br>
			<div class="resCard">
				<h3 style="text-align: center; margin-top: 100px;">답변</h3>
				<table class="outer">
					<tr class="tr" style="border-top: 1px solid black;">
						<th style="width: 15%;">제목</th>
						<td>${resQna.qnaTitle }</td>
					</tr>
					<tr class="tr">
						<th>작성일</th>
						<td><fmt:parseDate value="${resQna.qnaRegDate}"
								pattern="yyyy-MM-dd'T'HH:mm" var="regDate" type="both" /> <fmt:formatDate
								value="${regDate}" pattern="yyyy-MM-dd" /></td>
					</tr>
					<tr class="tr">
						<th>내용</th>
						<td>${resQna.qnaContent }</td>
					</tr>
				</table>
				<c:if test="${ resQna.qnaFile != null}">
					<img alt="" src="notice/setload/${resQna.qnaFile}"
						style="max-width: 100%; height: auto;">
				</c:if>

			</div>
		</c:if>
	</div>
	<div id="buttons" style="float: right">
		<c:if test="${loginUser.guestId eq qna.guestId.guestId}">
			<c:if test="${qna.qnaResYn eq 'n' }">
				<input type="button" value="수정하기" id="updateButton" class="button"
					onclick="location.href='qnaUpdate.do?no=${qna.qnaNo}'">
			</c:if>
			<input type="button" value="삭제하기" id="delete" class="button"
				onclick="go_delQna(${qna.qnaNo })">
		</c:if>
		<input type="button" value="문의홈" id="home" class="button"
			onclick="location.href='qnaHome.do'">
	</div>
</form>
<%@ include file="../footer.jsp"%>
