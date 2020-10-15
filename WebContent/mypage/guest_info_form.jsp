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
td {width:80px; padding:10px;}
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

.submit, .cancel {width:200px; height:50px; color:black; font-size:15px; margin:5px; background: white; border:1px solid #777;}
.menu input {cursor:pointer; margin:10px;}
.info_submenu ul .info_update a {text-decoration:none; color:black;}

</style>


<script>
$(document).on("keyup", ".phone", function() { 
	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); 
});


$(document).ready(function() {
	var gender=${gender};
	console.log(gender);
	if(gender==1){
		$("input[name=gender][value='1'").prop("checked",true);
	}else{
		$("input[name=gender][value='0'").prop("checked",true);
	}
	
	$('input[name="gender"]').click(function() { //클릭 이벤트 발생한 요소가 체크 상태인 경우
	     if ($(this).prop('checked')) {//체크박스 그룹의 요소 전체를 체크 해제후 클릭한 요소 체크 상태지정
	          $('input[name="gender"]').prop('checked', false);
	          $(this).prop('checked', true);
	     }
	});
	
	var infoYn = "${infoYn}";
	if(infoYn=='y'){
		$("input[name=infoYn]").prop("checked",true);
	}else{
		$("input[name=infoYn]").prop("checked",false);
	}
	
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

<form id="join" method="post" name="formm">
	<div id="wrapper">
		<p style="font-size:30px; text-align:center;">개인정보 변경</p>
		<table class="table">				<tr>
					<td>아이디</td>
					<td><input type="text" name="id"  value="${id}" readonly/> 
				</tr>
				<tr>
					<td>성명</td>
					<td><input type="text" name="name" value="${name}"/></td>
				</tr>				<tr>
					<td>생년월일</td>
					<td> <input type='date' name="birth" value="${birth}"/></td>
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
					<td><input type="text" name="email" value="${email}"> 
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="phone" class="phone" maxlength="13" value="${phone}">
				</tr>
			</table>
			<br>
			<div class="check">
				<input type="checkbox" name="infoYn" value="y" style="width:50px;">마케팅 수신에 동의합니다.<br></div>
			<br>
			<div id="buttons">
				<input type="submit" value="수정" class="submit" onclick="info_update()">
				<input type="button" value="취소" class="cancel" onclick="location.href='infoUpdate.do'">
			</div>
		</div>
	</form>
</body>

<%@ include file="../footer.jsp" %>  