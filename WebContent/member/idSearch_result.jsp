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
	<c:otherwise>
		고객님의 아이디는 ${id}입니다.
	</c:otherwise>
</c:choose>
</body>
