<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
    <%@ include file="../header.jsp" %>  
    <%@ include file="sub_menu.jsp" %>  
<style>
.info a{color: black; padding:30px 60px; border: 1px solid #ddd; border-top: 2px solid gray; border-bottom: 1px solid #ffffff;}

</style>
<body>

<div class="info_submenu">
	<ul>
		<li class="info_update"><a href="infoUpdate.do">개인정보 변경</a></li>  
		<li class="pwd_update"><a href="pwdUpdate.do">비밀번호 변경</a></li> 
	</ul>
</div>
<form method=post name=formm style="margin-right:0" action="pwdConfirm.do" >
<div class="content" style="text-align:center; padding:80px;">
<div class="underline">비밀번호 확인</div>

	<div class="clear" style="padding:20px;"></div>
회원님의 정보를 안전하게 보호하기 위해 <br>
비밀번호를 한번 더 입력하여 주세요. <br>
	<div class="clear" style="padding:10px;"></div>
<input type="password" name="pwd" placeholder="비밀번호" style="width:200px;">
<div class="clear" style="padding:5px;"></div>
<input type="button" name="btn" value="확 인" style="width:200px;" onclick="pwd_confirm()">
</div>
</form>
</body>

<%@ include file="../footer.jsp" %>  