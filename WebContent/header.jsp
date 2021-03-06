<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>hairrang</title>
<!-- <link rel="stylesheet" href="style.css"> -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="js/jquery.min.js"></script>
<script src="js/jquery.dropotron.min.js"></script>
<script src="js/skel.min.js"></script>
<script src="js/init.js"></script>
<script type="text/javascript" src="member/member.js"></script>
<script type="text/javascript" src="js/wow.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">

<!-- 아이콘 -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<!--아이콘-->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.12.1/css/all.css?ver=191202">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.12.1/css/v4-shims.css?ver=191202">
 
<!--slider -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<!-- 세부 페이지  적용 css -->
<link rel="stylesheet" href="css/design.css">
<style>
	#header {position:fixed; width:100%; z-index:9999; margin:0 auto; text-align:center;}
	#wrapper {width:1200px; margin:170px auto;}
	
</style>

</head>
<body class="homepage">

	<!-- Header Wrapper -->
	<div class="wrapper style1">

		<!-- Header -->
		<div id="header">
			<div>
				<!-- guestmenu -->
				
				<nav id="login-bar"> 
				<c:choose>
       			<c:when test="${empty sessionScope.loginUser}">
					<ul>
						<li><a href="login.do">login</a></li>
						<li><a href="contract.do">join</a></li>

					</ul>
				</c:when>
				<c:otherwise>
					
					<ul>
						 <li>
				         ${sessionScope.loginUser.guestName}(${sessionScope.loginUser.guestId})님 
				       	 </li>
				       	<li><a href="logout.do" style="font-weight:bold;">LOGOUT</a> / </li>
				       	<li><a href="infoUpdate.do"  style="font-weight:bold;">MYPAGE</a></li>
				    </ul>
				    
		       	</c:otherwise>       
		       	</c:choose>
				</nav>
				</div>
				
				<nav id="nav">
					<ul>
						<li><a href="index.do">HAIRRANG</a>
						<li><a href="about.do">ABOUT</a></li>
						<li><a href="">SALON</a>
							<ul>
								<li><a href="designerHome.do">DESIGNER</a></li>
								<li><a href="hBoard.do">HAIR</a></li>
								
							</ul></li>
						<li><a href="booking.do">RESERVATION</a></li>
						<li><a href="">COMMUNICATION</a>
							<ul>
								<li><a href="noticeHome.do">NOTICE</a></li>
								<li><a href="eventHome.do">EVENT</a></li>
								<li><a href="qnaHome.do">Q&A</a></li>
							</ul></li>
					</ul>
				</nav>
			
		
		</div>
	</div>
	<!--헤더파일 들어가는 곳 끝 -->
	<div id="wrapper">
	