<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
<style>
.content1-inner {
	width:450px;
	margin:0 auto;
	text-align:center;
	}
</style>
<link rel="stylesheet" href="css/design.css">
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="member/member.js"></script>
</head>
<body>

<form method=post name=formm style="margin-right:0" action="idpwSearch.do" >
  <section id="content1">
        <div class="content1-inner">
        <div class="clear" style="padding:5px;"></div>
        <h3>아이디 찾기</h3>
        <p style="size:10px">아이디는 가입 시 입력하신 <br>이름, 이메일을 통해 찾을 수 있습니다.</p><br>
       	<input type="text" name="id_name" placeholder="이름" style="width:430px; height:30px;">
       	<div class="clear" style="padding:5px;"></div>
       	<input type="text" name="id_email"  placeholder="이메일" style="width:430px; height:30px;">
       	<br><br>
       	<input type="button" value="찾기" onclick="idSearch()" style="width:420px; border:1px solid black; background:#fff; height:40px;">
       	<!-- onclick="location='index.do'" -->
       	<br>
    	</div>
    </section>
    </form>

</body>
</html>