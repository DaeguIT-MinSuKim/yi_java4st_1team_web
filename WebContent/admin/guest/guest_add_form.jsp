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
		$('input[name=pwdCheck]').attr("style","border:1px solid black;")
	  }
	});	  
	  
	$('input[name="gender"]').click(function() { //클릭 이벤트 발생한 요소가 체크 상태인 경우
	 	if ($(this).prop('checked')) {//체크박스 그룹의 요소 전체를 체크 해제후 클릭한 요소 체크 상태지정
			$('input[name="gender"]').prop('checked', false);
			$(this).prop('checked', true);
	  }
	});
	
	$('input[name="infoYn"]').click(function() { //클릭 이벤트 발생한 요소가 체크 상태인 경우
	 	if ($(this).prop('checked')) {//체크박스 그룹의 요소 전체를 체크 해제후 클릭한 요소 체크 상태지정
			$('input[name="infoYn"]').prop('checked', false);
			$(this).prop('checked', true);
	  }
	});
	
});



</script>
<style>
/* #add-wrapper {width:1200px; } */
.add-table {width:600px; }
.add-table tr td input {width:200px;}
.add-table tr {}
.add-table td {padding:20px; border-bottom:1px solid #858796;}
.add-table input {width:250px;}
.add-buttons {}
input {}


.info-buttons {text-align:center; margin:10px;}
</style>
<body>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">웹 고객 등록</h1>
<p class="mb-4">
	<a target="_blank" href="https://datatables.net"></a>
</p>
<form method="post" name="formm">
<!-- DataTales Example -->
<div class="card shadow mb-4" style="width:700px">
	<div class="card-header py-2">
		<h6 class="m-1 font-weight-bold text-primary" style="line-height: 16px; font-size: 1.3em">
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body">
		<div class="table-responsive">
			<!-- bootStrap table wrapper-->
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">


		<div id="add-wrapper">

			<table class="add-table">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id" /> 
					<input type="hidden" name="reid"></td>
					<td style="width:200px;"><input type="button" class="btn btn-info " value="중복확인" onclick="idcheck()" style="width: 100px;" /></td>
					
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pwd" id="pwd"/></td>
					<td></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" name="pwdCheck" id="pwdCheck"/></td>
					<td style="width: 100px;"><font size="2" color="gray" name="check"></font></td>
				</tr>
				<tr>
					<td>성명</td>
					<td><input type="text" name="name"/></td>
					<td></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td> <input type='date' name="birth"/></td>
					<td></td>
				</tr>
				<tr>
					<td>성별</td>
					<td><input type="checkbox" name="gender" value="0" style="width: 30px;">
						여성 
						<input type="checkbox" name="gender" value ="1" style="width: 30px;">
						남성</td>
						<td></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="email"> 
					<td></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="phone" class="phone" maxlength="13">
					<td></td>
				</tr>
				<tr>
					<td colspan="3" style="text-align:center;">마케팅 수신 동의<br><br>
						<input type="checkbox" name="infoYn" value="y" style="width: 30px;"> 동의
						<input type="checkbox" name="infoYn" value ="n" style="width: 30px;"> 거부
					</td>
						
						
				</tr>
			

			</table>
			<br><br>
			<div class="clear"></div>
			<br>
			<div class="add-buttons" style="float:right">
				<input type="button" value="등록" onclick="go_save()" class="btn btn-success">
				<input type="reset" value="취소" class="btn btn-light">
				
							</div>
				</div>
				<!-- bootStrap table wrapper-->
			</div>
			<!-- tableRespnsible -->
		</div>
		<!-- cardBody-->
	</div>
</div> 
</form>


<%@ include file="../include/footer.jsp" %>