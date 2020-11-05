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
	background-color: #C5C5DB;
	box-shadow: 5px 5px 5px 5px;
	color: #C866CA;
}
</style>
<script>
	$(document).ready(function() {
		$("#secret").change(function() {
			if ($('#secret').is(':checked')) {
				$('#secretPwd').prop('readonly', false);
			} else {
				$('#secretPwd').empty();
				$('#secretPwd').prop('readonly', true);

			}
		});

	});
</script>
<h3 style="text-align: center;">Q & A 작성</h3>
<form name="form" method="post" action="qnaWrite.do"
	enctype="multipart/form-data">
	<div class="content1-inner" style="text-align: center;">
		<p></p>
		<br> <input type="hidden" id="no" value="${qna.qnaNo }">
		<table class="outer">
			<tr class="tr" style="border-top: 1px solid black;">
				<th>제목</th>
				<td><input type="text" name="title" style="border: 1px solid #C5C5DB;
				"></td>
			</tr>
			<tr class="tr">
				<th style="vertical-align: middle;">내용</th>
				<td><textarea rows="8" cols="65" name="content" style="resize: none; border: 1px solid #C5C5DB;"></textarea></td>
			</tr>
			<tr style="border-bottom: 1px solid black;">
				<th>비밀글<input type="checkbox" name="secret" id="secret"
					value="sss"></th>
				<td><input type="text" name="secretPwd" id="secretPwd" readonly style="border: 1px solid #C5C5DB;"><br>
				</td>
			</tr>
		</table>
		<br> <input type="file" name="upload" style="float: left;">
	</div>
	<div id="rightButtons" class="outer" style="margin: 0px auto; text-align:right;">
		<input type="submit" value="제출하기" class="button"> <input
			type="reset" value="초기화" class="button">
	</div>
</form>
<%@ include file="../footer.jsp"%>
