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
.step {
	background:#f8f9fa;
	width:700px;
	height:80px;
	font-size:16px;
	text-align:center;
	display: table-cell;
    vertical-align: middle;
   	color:#c5c6ca;
}

.div-step{
	display:table;
	 margin:0 auto;
	 margin-top:50px;
}

.go_main{
	width:200px;
	height:60px;
	background: white;
	border:1px solid #777;
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
 <div class="div-step">
	<div class="step">STEP 01 약관 동의  <i class="xi-angle-right"></i> STEP 02 회원정보 입력   <i class="xi-angle-right"></i> <span style="color:black; font-weight:bold;"> STEP 03 회원가입 완료</span></div>
	</div>
	<br><br><br>
	<div class="content">
	<img src="images/gift.png"><br><br>
	<span style="font-size:25px;">${name}님의 회원가입을 <br> 축하합니다.<br><br></span>
	<span>신규 가입하신 회원님께 가입 쿠폰을 지급해드립니다.</span>
	<br><br><br>
	</div>
	
	<div class=div-button>
	<input type="button" value="메인페이지로 이동" class="go_main" onClick="location.href='index.do'">
	</div>
	
	
</body>

<%@ include file="../footer.jsp" %>   