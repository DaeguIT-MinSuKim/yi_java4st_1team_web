<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>hairrang</title>
<!-- <link rel="stylesheet" href="style.css"> -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="js/jquery.min.js"></script>
<script src="js/jquery.dropotron.min.js"></script>
<script src="js/skel.min.js"></script>
<script src="js/init.js"></script>
<script type="text/javascript" src="member/member.js"></script>
<style>
	body {text-align:Center;}
</style>
</head>
<body class="homepage">

	<!-- Header Wrapper -->
	<div class="wrapper style1">

		<!-- Header -->
		<div id="header">
			<div>
				<!-- guestmenu -->
				<nav id="guest"> 
				<c:choose>
       			<c:when test="${empty sessionScope.loginUser}">
					<ul>
						<li><a href="login.do">login</a></li>
						<li><a href="contract.do">join</a></li>

					</ul>
				</c:when>
				<c:otherwise>
				 <li>
		         ${sessionScope.loginUser.name}(${sessionScope.loginUser.id})님 안녕하세요.
		       	</li>
		       	<li><a href="logout.do">LOGOUT</a></li>
		       	</c:otherwise>       
		       	</c:choose>
				</nav>
				
				<nav id="nav">
					<ul>
						<li><a href="index.do">HAIRRANG</a>
						<li><a href="about.do">ABOUT</a></li>
						<li><a href="">SALON</a>
							<ul>
								<li><a href="designer.jsp">DESIGNER</a></li>
								<li><a href="hair.jsp">HAIR</a></li>
								
							</ul></li>
						<li><a href="reservationList.do">RESERVATION</a></li>
						<li><a href="">COMMUNICATION</a>
							<ul>
								<li><a href="notice.jsp">NOTICE</a></li>
								<li><a href="event.jsp">EVENT</a></li>
								<li><a href="qna.jsp">Q&A</a></li>
							</ul></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
	<!--헤더파일 들어가는 곳 끝 -->