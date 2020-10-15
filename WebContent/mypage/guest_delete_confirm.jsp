<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>  
<style>
.content {
	width:800px;
	margin:0 auto;
	text-align: Center;
	padding:100px;
	border-top:1px solid black;
	border-bottom:1px solid black;
}

.div-button {
	width:800px;
	margin:0 auto;
	text-align: Center;
	margin-top:100px;
	margin-bottom:100px;
}

</style>

<body>
<br><br><br>
	<div class="content">
	<img src="images/check.png"><br><br>
	<span style="font-size:25px;">탈퇴가 완료되었습니다.<br><br></span>
	<span>헤어랑을 이용해주셔서 감사합니다.</span>
	<br><br><br>
	</div>
	
	<div class=div-button>
	<input type="button" class="button" value="메인페이지로 이동" class="go_main" onClick="location.href='logout.do'">
	</div>
</body>

<%@ include file="../footer.jsp" %>   