<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>idCheck</title>
  <link href="css/sb-admin-2.min.css" rel="stylesheet">
  <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
  <link href="css/admin_custom.css" rel="stylesheet">
<script type="text/javascript">

function idok(){
  opener.formm.id.value="${id}"; 
  opener.formm.reid.value="${id}";
  self.close();
}

function search(){
	 if (opener.document.formm.id.value == "") {
		    alert("아이디를 입력하여 주세요.");
		    opener.document.formm.id.focus();
		    return;
	 }	    
}

	
</script>
<style>
#wrap {width:380px; text-align:center;}
</style>
<body>
<div id="wrap">
  <span style="font-size:20px; padding:10px; font-weight:bold">
  	ID 중복확인</span>
  <form method=post name=formm style="margin-right:0" action="idCheck.do" >
   <br><input type=text name="id" value="${param.id}"> 
            <input type="submit" name="search" onclick="search()" value="검색" class="btn btn-primary btn-sm"><br>
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
        <br><input type="button" value="사용" class="btn btn-primary btn-sm" onclick="idok()" style="margin:20px">
      </c:if>
    </div>
  </form>
</div>

</body>
</html>