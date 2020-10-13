<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<p style="font-size:30px; text-align:center;">비밀번호 변경</p>
<table class="table">
	<tr>
		<td>아이디</td>
		<td><input type="text" name="id" readonly/> 
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
			<td><font size="2" color="black" name="check"></font></td>
	</tr>
</table>
	<div id="buttons">
				<input type="button" value="수정" class="submit" onclick="go_save()">
				<input type="reset" value="취소" class="cancel">
		</div>
</body>