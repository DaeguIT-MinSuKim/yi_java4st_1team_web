<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<br>
<br>

<style>
body {
}

#wrapper {
	width:800px;
	margin:0 auto;
	text-align: Center;
	padding:100px;
}

fieldset {
	border-top:1px solid black;
	border-bottom:1px solid black;
	padding:50px;
	
}

fieldset input {
	margin:10px;
	}

.login-btn{
   background: gray;
    border: none;
    color: white; 
    text-transform: uppercase;
    border-radius: 0;
    font-size: 16px;
    height: 50px;
    width: 100%;
    }
.join-btn{
	background: gray;
    border: none;
    color: white; 
    text-transform: uppercase;
    border-radius: 0;
    font-size: 16px;
    height: 50px;
    width: 100%;
    }
    
.id, .pwd{
    box-shadow: none;
    padding: 10px;
    border: 1px solid #e8e8e8;
    width:100%;
    border-radius:10px;
}

.search {
	color:black;
	text-decoration:none;
}

.search:hover{
	text-decoration:underline;
	
	} 
	
.line {
	margin:0 auto;
	border:2px solid gray;
	width:120px;
	background:gray;
	}   
</style>
<body>
	<img src="images/shop.jpg" style="width: 100%;">
	<form class="login-form" method="post" action="login.do">
	<div id="wrapper">
		<div class="line"></div>
		<p style="font-size:40px; color:gray;">LOGIN</p>
		
		<br>
		<fieldset>
			<legend></legend>
			 <label></label>
			 <input name="id" type="text" placeholder="아이디" class="id"><br> 
			 <label></label>
			 <input name="pwd" type="password" placeholder="비밀번호" class="pwd"><br>
		
		<div class="clear" style="padding:10px;"></div>
		<div id="buttons">
			<input type="button" value="로그인" class="login-btn" onclick="location='index.do'"> 
			<input type="button" value="회원가입" class="join-btn" onclick="location='contract.do'">
			<br>
			<br>
			<a href="guestSearch.do" class="search">아이디/비밀번호 찾기</a>
		</div> 
		</fieldset>
		</div>
</form>

</body>
<%@ include file="../footer.jsp"%>
