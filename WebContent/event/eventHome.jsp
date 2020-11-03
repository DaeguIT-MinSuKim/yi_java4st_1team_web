<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ include file="../header.jsp" %> 
<style>

div.gallery {margin-top:100px;}
/* div.gallery:hover {border: 1px solid #777;} */
div.gallery img {width:50%; height:auto; float:left}
div.content {float:right; border:1px solid black;}

/*box-sizing: border-box; 지정안하면 padding, border값의 영향을 받아 box 길이값이 틀어지기 때문에 꼭 추가필요.*/
* { box-sizing: border-box; -webkit-box-sizing: border-box; -moz-box-sizing: border-box }

.responsive {
	display: inline-block;
	width: 100%;/*기본값 3개=30%*/
	vertical-align:top;
	margin: 0 auto;
	text-align:left;
	padding:20px;
}

/* 사용자 해상도가 700px 이하 일때는 2개씩 나열하기*/
@media only screen and (max-width: 1000px) {
  .responsive {
    width: 40%;
    margin: 6px 0;
  }
}
/*사용자 해상도가 500px 이하 일때는 1개씩 나열*/
@media only screen and (max-width: 600px) {
  .responsive {
    width: 100%;
  }
}

.clearfix:after {
  content: "";
  display: table;
  clear: both;
}


.de_wrapper {width:1200px;}
.de_sub_wrapper { width:1200px; margin:0 auto; }
</style>
<body>
<div class="de_wrapper">
<h3 style="text-align:center; padding:20px; margin-bottom:50px;">EVENT</h3>
<div class="de_sub_wrapper">
<div style=" width:900px; margin:0 auto; text-align:center">

<c:forEach var="event" items="${list}" varStatus="status">

<a href="eventDetail.do?eno=${event.eventNo}"><img src="event/images/${event.eventPic}" alt="" width=60%></a>
<div style="font-size:22px; font-weight :bold; padding:10px;">${event.eventName}</div>
   		<div>
   			<img src="images/cal-b.png" width=2% style="margin-bottom:-3px;"> ${event.eventStart} ~ 
   			<c:if test="${event.eventEnd == '9999-12-30'}">상시적용</c:if>
   			<c:if test="${event.eventEnd != '9999-12-30'}">${event.eventEnd}</c:if>
   		</div>
   		<br><br>
   		<br><br>
</c:forEach> 


</div>
</div>
<div class="clearfix"></div>

<div style="padding:6px;">
</div>
</div>

	<div class=".clear"></div>
</body>
<%@ include file="../footer.jsp" %>   