<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
    <%@ include file="../header.jsp" %>  
    <%@ include file="sub_menu.jsp" %>  
<style>
.info a{background-color:white;  border-bottom:1px solid white;}
.btn { width:250px; height:50px; color:black; border:none; font-size:15px; margin:5px; background: white; border:1px solid #777;}
</style>
<body>


<div class="info_submenu">
	<a href="infoUpdate.do">개인정보 변경</a> | 
	<a href="pwdUpdate.do">비밀번호 변경</a> | 
	<a href="infoDelete.do">회원탈퇴</a>
</div>

<form method=post name=formm style="margin-right:0" action="pwdConfirm.do" >
<div class="content" style="text-align:center; padding:80px;">
<div class="underline">비밀번호 확인</div>

	<div class="clear" style="padding:20px;"></div>
회원님의 정보를 안전하게 보호하기 위해 <br>
비밀번호를 한번 더 입력하여 주세요. <br>
	<div class="clear" style="padding:10px;"></div>
<input type="password" name="pwd" placeholder="비밀번호" style="width:250px;">
<div class="clear" style="padding:5px;"></div>
<input type="button" class="btn" value="확   인" onclick="pwd_confirm()">
</div>
</form>
</body>

<%@ include file="../footer.jsp" %>  