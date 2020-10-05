<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ include file="../header.jsp" %>  
	<br>
	<br>
	<br><br>
<style>
#wrapper{
}

.table {
	width:600px;
	margin:0 auto;
	padding:20px;
}
td {width:80px; padding:10px;}
input {width:200px; border-radius:5px;  border: 1px solid #e8e8e8;}

.line {
	margin:0 auto;
	border:2px solid gray;
	width:120px;
	background:gray;
	} 
	
.check {text-align:center;}
#buttons {width:800px; margin:0 auto; text-align:Center; padding:50px;}
.submit, .cancel {width:200px;}
</style>
<body>
	<form>
		<div id="wrapper">
			<div class="line"></div>
			<p style="text-align: center; font-size: 40px">JOIN</p>
			<table class="table">
				<tr>
					<td>아이디</td>
					<td><input type="text" /> <input type="button" value="중복확인"
						style="width: 100px; margin-left:30px;" /></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" /></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" />&nbsp;</td>
				</tr>
				<tr>
					<td>성명</td>
					<td><input type="text" /></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td> <input type='date'/></td>
				</tr>
				<tr>
					<td>성별</td>
					<td><input type="checkbox" name="gender" style="width: 30px;">
						여성 <input type="checkbox" name="gender" style="width: 30px;">
						남성</td>
				</tr>
				<!-- <tr>
					<td>이메일</td>
					<td><input type="text" style="width: 120px;"> @ <input
						type="text" style="width: 120px;"> &nbsp;&nbsp; <select>
							<option>직접입력</option>
							<option>naver.com</option>
							<option>daum.net</option>
							<option>nate.com</option>
					</select></td>
				</tr> -->
				<tr>
					<td>휴대폰</td>
					<td><input type="text" style="width: 50px;"> - <input
						type="text" style="width: 50px;"> - <input type="text"
						style="width: 50px;"></td>
				</tr>
			

			</table>
			<div class="clear"></div>
			<div class="check"><input type="checkbox" name="phone" checked style="width:50px;">마케팅 수신에 동의합니다.<br>(동의하지 않으셔도 회원가입이 가능합니다.)<br></div>
			
			<div id="buttons">
				<input type="button" value="회원가입" class="submit" onclick="go_save()">
				<input type="reset" value="취소" class="cancel">
			</div>
		</div>
	</form>

</body>

<%@ include file="../footer.jsp" %>   