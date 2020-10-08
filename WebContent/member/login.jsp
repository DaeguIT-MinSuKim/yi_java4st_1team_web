<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<br>
<br>
<script>
   /*전체적용 할 페이지에 이거 쓰면됨~~~~~*/
   $(function(){
	   if ($(".main").length > 0 ){
	      $("#wrapper").css({width:'100%'});      
	      $("#wrapper").css({margin:'40px auto'});  
	   }
	   
   })

</script>
<style>

#subwrapper {
	width:600px;
	margin:0 auto;
	text-align: Center;
	margin-bottom:120px;
}

fieldset {
	border-top:1px solid black;
	border-bottom:1px solid black;
	padding:50px;
	
}

fieldset input {
	margin:10px;
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
	

.login-button {width:100%; height:50px; color:black; border:none; font-size:15px; font-weight:bold; margin:5px; background: white; border:1px solid #777; cursor: pointer;}   
.search {border:none; background-color: #fff;}
</style>
<body>

<div class="main">
	<img src="images/main1.jpg" style="width: 100%; top:0;">
	<form method="post" action="login.do">
	<div id="subwrapper">
		<!-- div class="line"></div> -->
		<br><br><p style="font-size:40px; color:gray;">LOGIN</p>
		<fieldset>
			<legend></legend>
			 <label></label>
			 <input name="id" type="text" placeholder="아이디" class="id"><br> 
			 <label></label>
			 <input name="pwd" type="password" placeholder="비밀번호" class="pwd"><br>
		
		<div class="clear" style="padding:10px;"></div>
		<div id="buttons">
			<input type="submit" class="login-button" value="로 그 인" onclick="location='index.do'"> 
			<input type="button" class="login-button" value="회 원 가 입" onclick="location='contract.do'">
			<br>
			<br>
			<input type="button" class="search" value="아이디/비밀번호 찾기" onclick="idpwSearch()">
		</div> 
		</fieldset>
		</div>

</form>
</div>
</body>
<%@ include file="../footer.jsp"%>
