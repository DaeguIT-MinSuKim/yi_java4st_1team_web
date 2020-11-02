<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>idCheck</title>
<style>
#wrap {
	width:300px;
	margin:0 auto;	
	text-align:center;
	padding:20px;
}
.submit, .cancel{color:black; font-size:15px; background: white; border:1px solid #777;}
</style>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

function idok(){
	console.log(this.value)
  opener.formm.id.value="${id}"; 
  opener.formm.reid.value="${id}";
  self.close();
}

function submit(){
	console.log($('input[name=id]').val());
	
}



</script>
<body>
<div id="wrap">
  <h3 style="text-align:center">ID 중복확인</h3>
  <form method=post name=formm style="margin-right:0" action="idCheck.do" >
   ID <input type=text name="id" value="${param.id}" id="id"> 
            <input type="button" value="검색" class="submit" onclick="submit()"><br>
<span id = "chkMsg"></span>      
    <div style="margin-top: 20px">   
      <c:if test="${message == 1}">
        <script type="text/javascript">
          opener.document.formm.id.value="";
        </script>
        ${id}는 이미 사용중인 아이디입니다.
      </c:if>
      <c:if test="${message==-1}">
        ${id}는 사용 가능한 ID입니다.
        <input type="button" value="사용" class="cancel" onclick="idok()">
      </c:if>
    </div>
  </form>
</div>  
</body>
</html>