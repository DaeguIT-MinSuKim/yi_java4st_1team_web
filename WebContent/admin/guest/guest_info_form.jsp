<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ include file="../include/header.jsp" %>
<script>
$(document).ready(function() {
	var gender=${guest.guestGender};
	if(gender==1){
		$("input[name=gender][value='1'").prop("checked",true);
	}else{
		$("input[name=gender][value='0'").prop("checked",true);
	}

	var infoYn = '${guest.infoYn}';
	console.log('${guest.infoYn}');
	if(infoYn== 'y'){
		$("input[name=infoYn]").prop("checked",true);
	}else{
		$("input[name=infoYn]").prop("checked",false);
	}
	

	$('input[name="gender"]').click(function() { //클릭 이벤트 발생한 요소가 체크 상태인 경우
	     if ($(this).prop('checked')) {//체크박스 그룹의 요소 전체를 체크 해제후 클릭한 요소 체크 상태지정
	          $('input[name="gender"]').prop('checked', false);
	          $(this).prop('checked', true);
	     }
	});
});
</script>
<style>
#info-wrapper {width:1000px; margin:0 auto;}
.info-table {width:1000px;}
.info-table tr {border-bottom:1px solid #e9e9e9;}
.info-table td {padding:20px;}
.info-table input {width:250px;}

.info-buttons {text-align:center; margin:10px;}
</style>
<form id="join" method="post" name="formm">
	<div id="info-wrapper">
		<table class="info-table">				
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id"  value="${guest.guestId}" readonly/> 
				<tr>
				<tr>
					<td>성명</td>
					<td><input type="text" name="name" value="${guest.guestName}"/></td>
				</tr>				<tr>
					<td>생년월일</td>
					<td> <input type='date' name="birth" value="${guest.guestBirthday}"/></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="phone" class="phone" maxlength="13" value="${guest.guestPhone}">
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="email" value="${guest.guestEmail}"> 
				</tr>
				<tr>
					<td>성별</td>
					<td><input type="checkbox" name="gender" value="0" style="width: 30px;">
						여성 
						<input type="checkbox" name="gender" value="1" style="width: 30px;">
						남성</td>	
				</tr>
				<tr>
					<td>가입일</td>
					<td><input type="text" name="email" value="${guest.guestJoinDate}" readonly></td>
				</tr>
				<tr>
					<td>고객 메모</td>
					<td><input type="text" name="email" style="height:100px;"" value="${guest.guestNote}"></td>
				</tr>
				<tr>
					<td>탈퇴 여부</td>
					<td><input type="text" name="email" value="${guest.delYn}"></td>
				</tr>
				<tr>
					<td>마케팅 활용동의</td>
					<td><input type="checkbox" name="infoYn" style="width:50px;"></td>
				</tr>
			</table>
			<br>
			<br>
			<div class="info-buttons">
				<input type="submit" value="정보 수정" class="submit" onclick="info_update()">
				<input type="button" value="취소" class="cancel" onclick="location.href='infoUpdate.do'"><br>
				<input type="button" value="탈퇴 전환" class="cancel">
			</div>
		</div>
	</form>

<%@ include file="../include/footer.jsp" %>