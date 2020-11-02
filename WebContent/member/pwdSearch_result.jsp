<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  

<body>
<c:choose>
	<c:when test="${message == -1}">
	 	<script>
	          alert('존재하지 않는 회원입니다.')
	          history.go(-1);
	    </script>
	</c:when>
	<c:when test="${error ne null}">
	 	<script>
	          alert(${error});
	          history.go(-1);
	    </script>
	</c:when>
	<c:otherwise>
		${name}님의 메일주소로 임시 비밀번호를 전송하였습니다.<br> 로그인 후 비밀번호를 변경하세요.
	</c:otherwise>
</c:choose>
</body>