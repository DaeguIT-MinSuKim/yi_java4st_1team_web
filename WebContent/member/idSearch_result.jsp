<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
function go_pwdSearch() {
	var url="pwdSearch.do";
	window.open( url, "_blank_1",
	"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=500, height=400");
}
function confirm(){
	self.close();
}
</script>
<body>
<c:choose>
	<c:when test="${message == -1}">
	 	<script>
	          alert('존재하지 않는 회원입니다.')
	          history.go(-1);
	    </script>
	</c:when>
	<c:otherwise>
		<div style="text-align:center; margin-top:100px">
			<p>고객님의 아이디는 ${id}입니다.</p><br>
			<input type="button" value="확인" style="width:420px; border:1px solid black; background:#fff; height:40px;" onclick="confirm()">
			<div class="clear" style="padding:5px;"></div>
			<input type="button" value="비밀번호 찾기" style="width:420px; border:1px solid black; background:#fff; height:40px;" onclick="go_pwdSearch()">
		</div>
	</c:otherwise>
</c:choose>
</body>
