<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>idCheck</title>
<script type="text/javascript">

$('#myModal').on('shown.bs.modal', function () {
	  $('#myInput').trigger('focus')
})

function idok(){
  opener.formm.id.value="${id}"; 
  opener.formm.reid.value="${id}";
  self.close();
}
</script>
<body>
<div id="wrap">
  <h2>ID 중복확인</h2>
  <form method=post name=formm style="margin-right:0" action="idCheck.do" >
   ID <input type=text name="id" value="${param.id}"> 
            <input type=submit value="검색" class="submit"><br>
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