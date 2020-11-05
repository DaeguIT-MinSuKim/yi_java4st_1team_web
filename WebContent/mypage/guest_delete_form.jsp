<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
    <%@ include file="../header.jsp" %>  
    <%@ include file="sub_menu.jsp" %>  
<style>
.info a{background-color:white;  border-bottom:1px solid white;}
</style>
<body>

<div class="info_submenu">
	<a href="infoUpdate.do">개인정보 변경</a> | 
	<a href="pwdUpdate.do">비밀번호 변경</a> | 
	<a href="infoDelete.do" style="font-weight:bold">회원탈퇴</a>
</div>


<form method=post name=formm style="margin-right:0" action="guestInfoDelete.do" >
<div class="delete_wrapper">
	<p style="font-size:27px;"><i class="fas fa-user-check" style="color:gray"></i>
	  회원 탈퇴 시 아래 유의사항을 반드시 확인하시기 바랍니다.</p> <br> 
	<div class="delete_sub1">
	탈퇴 시 아이디는 재사용 및 복구 불가능합니다. 
		 <div class="check">
		     	<input type="checkbox" name="ok">동의함 <br><br>
		 </div>
	</div>
	<div class="delete_sub2">
	온라인 회원의 개인혜택과 회원정보는 자동 소멸됩니다. 
	 <div class="check">
	     	<input type="checkbox" name="ok">동의함 <br><br>
	     </div>
	</div>
	<div class="delete_sub3">
	게시판형 서비스에 등록하신 게시글은 삭제가 불가능합니다. 
	<div class="check">
	     	<input type="checkbox" name="ok">동의함 <br><br>
	     </div>
	</div>     
	  <input type="button" class="button" value="탈  퇴" onclick="go_leave()"> 
	      <input type="button" class="button" value="취  소" > 
	</div>
</form>

</body>

<%@ include file="../footer.jsp" %>  