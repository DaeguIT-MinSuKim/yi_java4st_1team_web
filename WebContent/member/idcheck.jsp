<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>idCheck</title>
<script type="text/javascript">

function idok(){
  opener.formm.id.value="${id}"; 
  opener.formm.reid.value="${id}";
  self.close();
}
</script>
<body>
<div id="wrap">
  <h2>ID �ߺ�Ȯ��</h2>
  <form method=post name=formm style="margin-right:0" action="idCheck.do" >
   ID <input type=text name="id" value="${param.id}"> 
            <input type=submit value="�˻�" class="submit"><br>
<span id = "chkMsg"></span>      
    <div style="margin-top: 20px">   
      <c:if test="${message == 1}">
        <script type="text/javascript">
          opener.document.formm.id.value="";
        </script>
        ${id}�� �̹� ������� ���̵��Դϴ�.
      </c:if>
      <c:if test="${message==-1}">
        ${id}�� ��� ������ ID�Դϴ�.
        <input type="button" value="���" class="cancel" onclick="idok()">
      </c:if>
    </div>
  </form>
</div>  
</body>
</html>