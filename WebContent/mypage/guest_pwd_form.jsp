<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>	
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
    <%@ include file="../header.jsp" %>  
    <%@ include file="sub_menu.jsp" %>  

<style>
.info a{color: black; padding:30px 60px; border: 1px solid #ddd; border-top: 2px solid gray; border-bottom: 1px solid #ffffff;}
.underline {font-size:30px;}
.table {
	width:550px;
	margin:0 auto;
	padding:20px;
}
td {width:100px; padding:10px;}
input {margin-left:20px; width:260px; border: 1px solid #e8e8e8;}

.line {
	margin:0 auto;
	border:2px solid gray;
	width:120px;
	background:gray;
	} 	
.check {text-align:center;}
#buttons {width:800px; margin:0 auto; text-align:Center; padding:50px;}
.submit, .cancel {width:200px;}

.submit, .cancel {width:80px; height:50px; color:black; border:none; font-size:15px; margin:5px; width:200px; background: white; border:1px solid #777;}
.menu input {cursor:pointer; margin:10px;}
.info_submenu ul .pwd_update a {text-decoration:none; color:black;}
</style>

<script>
/*비밀번호 확인 체크*/
$(function(){
 $('#pwd').keyup(function(){
  $('font[name=check]').text('');
	 }); //#user_pass.keyup

 $('#pwdCheck').keyup(function(){
	  if($('#pwd').val()!=$('#pwdCheck').val()){
	  	$('font[name=check]').text('');
	   	$('font[name=check]').html("암호가 일치하지 않습니다.");
	   	$('input[name=pwdCheck]').attr("style","border:2px solid #e16a93")
	  }else{
	  	$('font[name=check]').text('');
	  	$('font[name=check]').html("암호가 일치합니다.");
		$('input[name=pwdCheck]').attr("style","border:1px solid black")
	  }
 });
});
</script>
<body>
<c:choose>
	<c:when test="${message == -1}">
	 	<script>
	          alert('비밀번호가 맞지 않습니다.')
	          history.go(-1);
	    </script>
	</c:when>
	<%-- <c:when test="${message == -2}">
	 	<script>
	          alert('로그인이 필요합니다.')
	         location.href="login.do";
	    </script>
	</c:when> --%>
</c:choose>

<div class="info_submenu">
	<ul>
		<li class="info_update"><a href="infoUpdate.do">개인정보 변경</a></li>  
		<li class="pwd_update"><a href="pwdUpdate.do">비밀번호 변경</a></li> 
		<li class="guest_delete"><a href="infoDelete.do">회원탈퇴</a></li> 
	</ul>
</div>
<form method="post" name="formm">
<p style="font-size:30px; text-align:center;">비밀번호 변경</p>
<table class="table">
	<tr>
		<td>아이디</td>
		<td><input type="text" name="id" value="${id}" readonly/> 
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="pwd" id="pwd"/></td>
	</tr>
	<tr>
		<td>비밀번호 확인</td>
		<td><input type="password" name="pwdCheck" id="pwdCheck"/>
	</tr>
	<tr>
		<td></td>
		<td style="padding-left:40px;"><font size="2" color="black" name="check"></font></td>
	</tr>
</table>
	<div id="buttons">
				<input type="button" value="수정" class="submit" onclick="pwd_update()">
				<input type="reset" value="취소" class="cancel">
		</div>
</form>
</body>