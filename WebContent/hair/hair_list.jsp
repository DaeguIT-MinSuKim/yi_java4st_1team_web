<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../header.jsp" %> 
<style>

div.gallery {margin-top:20px;}
/* div.gallery:hover {border: 1px solid #777;} */
div.gallery img {width: 100%; height:auto; }
div.content {}

/*box-sizing: border-box; 지정안하면 padding, border값의 영향을 받아 box 길이값이 틀어지기 때문에 꼭 추가필요.*/
* { box-sizing: border-box; -webkit-box-sizing: border-box; -moz-box-sizing: border-box }

.responsive {
	display: inline-block;
	width: 30%;/*기본값 3개=30%*/
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

.hair_cate {text-align:center;}
.hair_cate a {text-decoration:none; color:black;}

</style>
<body>

${cateNoList}

<div class="hair_cate">
	<a href="hBoard.do">ALL</a> | 
	<a href="hBoard.do?category=1">SHORT</a> | 
	<a href="hBoard.do?category=2">MEDIUM</a> | 
	<a href="hBoard.do?category=3">LONG</a> | 
	<a href="hBoard.do?category=4">MAN</a>
</div>

<div class="de_wrapper">
<div class="de_sub_wrapper">
<div style=" width:1000px; margin-left:100px;">
<c:if test="${board == null}">
	<c:forEach var="list" items="${list}" varStatus="status">
		<div class="responsive"> <!-- 사진 하나 -->
		  <div class="gallery">
		      <img src="${list.hbPic}" alt="">
		  </div>
	</div>
	</c:forEach>
</c:if>
<c:if test="${board != null}">
<c:forEach var="list" items="${board}" varStatus="status">
	<div class="responsive"> <!-- 사진 하나 -->
	  <div class="gallery">
	      <img src="${list.hbPic}" alt="">
	  </div>
</div>
</c:forEach>
</c:if>
</div>
</div>
<div class="clearfix"></div>

<div style="padding:6px;">
</div>
</div>
</body>

<%@ include file="../footer.jsp" %>   