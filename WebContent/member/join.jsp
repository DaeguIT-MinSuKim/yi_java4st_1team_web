<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ include file="../header.jsp" %>  

<style>
.table {
	width:500px;
	margin:0 auto;
	padding:20px;
}
td {width:80px; padding:10px;}
input {width:200px; border: 1px solid #e8e8e8;}

.line {
	margin:0 auto;
	border:2px solid gray;
	width:120px;
	background:gray;
	} 
	
.check {text-align:center;}
#buttons {width:800px; margin:0 auto; text-align:Center; padding:50px;}
.submit, .cancel {width:200px;}
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
	padding-top:50px;
	display:table;
	 margin:0 auto;
}
</style>

<script>
$(document).on("keyup", ".phone", function() { 
	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); });


</script>
<body>
	<form id="join" method="post" name="formm">
		<div id="wrapper">
			
	 <div class="div-step">
	<div class="step">STEP 01 약관 동의  <i class="xi-angle-right"></i><span style="color:black; font-weight:bold;">  STEP 02 회원정보 입력   </span><i class="xi-angle-right"></i> STEP 03 회원가입 완료</div>
	</div>
	<br><br><br>
			<table class="table">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id" /> 
					<input type="button" name="" value="중복확인" style="width: 100px; margin-left:30px;" /></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pwd"/></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" name="pwdCheck" />&nbsp;</td>
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
			

			</table>
			<br><br>
			<div class="clear"></div>
			<div class="check"><input type="checkbox" name="infoCheck" value="y" checked style="width:50px;">마케팅 수신에 동의합니다.<br>(동의하지 않으셔도 회원가입이 가능합니다.)<br></div>
			<br>
			<div id="buttons">
				<input type="button" value="회원가입" class="submit" onclick="go_save()">
				<input type="reset" value="취소" class="cancel">
			</div>
		</div>
	</form>

</body>

<%@ include file="../footer.jsp" %>   