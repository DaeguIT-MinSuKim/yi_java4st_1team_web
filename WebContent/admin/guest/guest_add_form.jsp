<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 


<style>

</style>

<script>
$(document).on("keyup", ".phone", function() { 
	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); });

/*비밀번호 확인 체크*/
$(document).ready(function(){
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
	  
	$('input[name="gender"]').click(function() { //클릭 이벤트 발생한 요소가 체크 상태인 경우
	 	if ($(this).prop('checked')) {//체크박스 그룹의 요소 전체를 체크 해제후 클릭한 요소 체크 상태지정
			$('input[name="gender"]').prop('checked', false);
			$(this).prop('checked', true);
	  }
	});
});



</script>
<style>
#add-wrapper {width:1000px; margin:0 auto;}
.add-table {width:1000px;}
.add-table tr {border-bottom:1px solid #e9e9e9;}
.add-table td {padding:20px;}
.add-table input {width:250px;}
.add-buttons {text-align:center;}


.info-buttons {text-align:center; margin:10px;}
</style>
<body>
	<form method="post" name="formm">
		<div id="add-wrapper">

			<table class="add-table">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id" /> 
					<input type="hidden" name="reid">
					<input type="button" class="idCheck" value="중복확인" onclick="idcheck()" style="width: 100px; margin-left:30px;" /></td>
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
				<tr>
					<td>성명</td>
					<td><input type="text" name="name"/></td>
				</tr>
				<tr>
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
				<tr>
					<td colspan="2" style="text-align:center;">마케팅 수신 동의
						<input type="checkbox" name="infoYn" value="0" style="width: 30px;"> Y
						<input type="checkbox" name="infoYn" value ="1" style="width: 30px;"> N
						</td>
				</tr>
			

			</table>
			<br><br>
			<div class="clear"></div>
			<br>
			<div class="add-buttons">
				<input type="button" value="등록" onclick="go_save()">
				<input type="reset" value="취소">
				
				
			</div>
		</div>
	</form>


<%@ include file="../include/footer.jsp" %>