<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
    <%@ include file="../header.jsp" %>  
    <%@ include file="sub_menu.jsp" %>  
<style>
.info a{color: black; padding:30px 60px; border: 1px solid #ddd; border-top: 2px solid gray; border-bottom: 1px solid #ffffff;}
.book a {color:#bbb;}
.order a {color:#bbb;}
.qna a {color:#bbb;}
.underline {font-size:30px;}
.table {
	width:550px;
	margin:0 auto;
	padding:20px;
}
td {width:80px; padding:10px;}
input {width:260px; border: 1px solid #e8e8e8;}

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
</style>


<script>
$(document).on("keyup", ".phone", function() { 
	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); });

/*비밀번호 확인 체크*/
$(function(){
 $('#pwd').keyup(function(){
  $('font[name=check]').text('');
	 }); //#user_pass.keyup

 $('#pwdCheck').keyup(function(){
	  if($('#pwd').val()!=$('#pwdCheck').val()){
	  	$('font[name=check]').text('');
	   	$('font[name=check]').html("암호가 일치하지 않습니다.");
	   	$('input[name=pwdCheck]').attr("style","border:1px solid #e16a93")
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
</c:choose>

<div class="info_submenu">
	<ul>
		<li class="info_update"><a href="guestInfo.do">개인정보 변경</a></li>  
		<li class="pwd_update"><a href="guestInfo.do">비밀번호 변경</a></li> 
	</ul>
</div>

<form id="join" method="post" name="formm">
	<div id="wrapper">
		<p style="font-size:30px; text-align:center;">개인정보 변경</p>
		<table class="table">				<tr>
					<td>아이디</td>
					<td><input type="text" name="id"  value="${id}" readonly/> 
					<input type="hidden" name="reid"">
				</tr>
				<tr>
					<td>성명</td>
					<td><input type="text" name="name"/></td>
				</tr>				<tr>
					<td>생년월일</td>
					<td> <input type='date' name="birth"/></td>
				</tr>
				<tr>
					<td>성별</td>
					<td><input type="checkbox" name="gender" value="0" style="width: 30px;">
						여성 
						<input type="checkbox" name="gender" value ="1" style="width: 30px;">
						남성</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="email"> 
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="phone" class="phone" maxlength="13">
				</tr>
			

			</table>
			<br>
			<div class="check"><input type="checkbox" name="infoCheck" value="y" checked style="width:50px;">마케팅 수신에 동의합니다.<br></div>
			<br>
			<div id="buttons">
				<input type="button" value="수정" class="submit" onclick="go_save()">
				<input type="reset" value="취소" class="cancel">
			</div>
		</div>
	</form>
</body>

<%@ include file="../footer.jsp" %>  