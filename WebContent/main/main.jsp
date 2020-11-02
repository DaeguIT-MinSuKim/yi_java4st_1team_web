<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %>  

<script>
   /*전체적용 할 페이지에 이거 쓰면됨~~~~~*/
   $(function(){
	   if ($(".main").length > 0 ){
	      $("#wrapper").css({width:'100%'});
	      $("#wrapper").css({margin:'96px auto'});    
	   }
   })
   
  
</script>
<script src="../package/swiper-bundle.min.js"></script>
<style>
	img {margin-bottom:-6px;}
	.main {text-align:center; margin:0 auto;}
	.more {margin:0 auto; border:2px solid gray; width: 90px;}
	.more a { text-align:center;text-decoration:none; color:gray; font-size:20px; font-weight:bold;}

/* Banner */

	#banner {
		padding: 18em 0 10em 0;
		background-image: url('images/main.jpg');
		background-size: contain;
		background-position: top;
		background-attachment: fixed;
		background-repeat: no-repeat;
		text-align: center;
		border-top: 0.5em solid #5385c1;
		
	}

	#banner h1 {
			font-size: 2em;
			font-weight: 100;
			color: #fff;
			line-height: 1em;
			margin: 0 0 0.5em 0;
			padding: 0;
		}

	#banner p {
			font-size: 1em;
			color: rgba(255, 255, 255, 0.55);
			margin-bottom: 1.75em;
		}

</style>

<div class="main">

<section class="slider">
<%-- <%@ include file="/slider.jsp" %>   --%>
<%-- <%@ include file="/slider2.jsp" %> --%>
<!-- <img src="images/main.jpg" width="100%"> -->
</section>

<section id="banner">
		<h1>Find your self,</h1>
		<p>with Rang hair designers group.</p>
		<div style="border:2px solid white; width:150px; padding:10px; margin:0 auto; border-radius:10px; color:white; font-weight:bold;cursor:pointer" onclick="location.href='booking.do'" ">
			RESERVATION
		</div>
</section>
<br>
<br>

<!-- 
<a href="qnaList.do">QnaTest</a> -->
<br>
<div id="insta">
<p style="font-size:30px; font-weight:600">#INSTAGRAM</p><br>
<img src="images/insta_mini.png"><span style="clear:both;font-size:15px; font-weight:600;"> hairrang_official</span><br><br>
<%@ include file="/insta.jsp" %>


<br><br>
<div class="more"><a href="http://instagram.com/hairrang_official"  target="_blank">MORE</a></div>
<br><br><br><br><br>
<p style="font-size:30px; font-weight:600">DESIGNERS</p><br>
디자이너 게시판에 사진 갤러리형식으로 넣을겅ㅇ임

</div>
</div>
<%@ include file="/footer.jsp" %>   