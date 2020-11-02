<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ include file="../include/header.jsp" %>

<style>
#info-wrapper {width:600px; margin:0 auto; }
.info-table {width:600px;}
.info-table tr {border-bottom:1px solid #e9e9e9;}
.info-table td {padding:20px;}
.info-table input {width:250px;}

.info-buttons {text-align:center; margin:10px;}
</style>
<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">고객 정보 </h1>
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

	<div id="info-wrapper">
		<table class="info-table">				
				<tr>
					<td>아이디</td>
					<td>${guest.guestId}</td> 
				<tr>
				<tr>
					<td>성명</td>
					<td>${guest.guestName}</td>
				</tr>				<tr>
					<td>생년월일</td>
					<td>${guest.guestBirthday}</td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td>${guest.guestPhone}
				</tr>
				<tr>
					<td>이메일</td>
					<td>${guest.guestEmail}
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<c:if test="${guest.guestGender==0}">여성</c:if>
						<c:if test="${guest.guestGender==1}">남성</c:if>		
					</td>	
				</tr>
				<tr>
					<td>가입일</td>
					<td>
					<fmt:parseDate value="${guest.guestJoinDate}" pattern="yyyy-MM-dd'T'HH:mm" var="join" type="both" />
					<fmt:formatDate value="${join}" pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
				<tr>
					<td>고객 메모</td>
					<td>${guest.guestNote}</td>
				</tr>
				<tr>
					<td>탈퇴 여부</td>
					<td>${guest.delYn}</td>
				</tr>
				<tr>
					<td>마케팅 수신동의</td>
					<td>
						<c:if test="${guest.infoYn == 'y'}">동의</c:if>
						<c:if test="${guest.infoYn =='n'}">거부</c:if>		
					</td>
				</tr>
			</table>
			<br>
			<br>
			<div class="info-buttons">
				<input type="button" value="정보 수정" class="btn btn-primary btn-sm" onclick="location.href='guestInfo.do?id='+'${guest.guestId}' ">
				<input type="button" value="목록" class="btn btn-light btn-sm " onclick="location.href='guestList.do' "><br>
			</div>
		</div>
		<!-- cardBody-->

</div>
</div>
</div>
</div> 
</form>


<%@ include file="../include/footer.jsp" %>