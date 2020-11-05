<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>

.content2-inner {
	width:450px;
	margin:0 auto;
	text-align:center;
	}

</style>
<link rel="stylesheet" href="css/design.css">
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="member/member.js"></script>
<body>
<form method=post name=formm style="margin-right:0" action="pwdSearch.do" >
<section id="content2">
    	
    	<div class="content2-inner">
       	<div class="clear" style="padding:5px;"></div>
       	<h3>비밀번호 찾기</h3>
        <p style="size:10px">입력된 이메일로 임시 비밀번호가 전송됩니다.</p><br>
       	<input type="text" name="id" placeholder="아이디" style="width:430px; height:30px;">
       	<div class="clear" style="padding:5px;"></div>
       	<input type="text" name="name"  placeholder="이름" style="width:430px; height:30px;">
       	<div class="clear" style="padding:5px;"></div>
       	<input type="text" name="email"  placeholder="이메일" style="width:430px; height:30px;">
       	<br><br>
       	<input type="button" value="찾기" onclick="pwdSearch()" style="width:420px; border:1px solid black; background:#fff; height:40px;">
    	</div>
    </section>
</form>
</body>
