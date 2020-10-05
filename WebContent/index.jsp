<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>  

<br>
<br>
<script>
   /*전체적용 할 페이지에 이거 쓰면됨~~~~~*/
   $(function(){
	   if ($(".main").length > 0 ){
	      $("#wrapper").css({width:'100%'});      
	   }
   })

</script>
<script src="../package/swiper-bundle.min.js"></script>
<style>
	img {margin-bottom:-6px;}
	.main {text-align:center; margin:0 auto;}
	.more {margin:0 auto; border:3px solid gray; width: 120px;}
	.more a { text-align:center;text-decoration:none; color:gray; font-size:20px; font-weight:bold;}

</style>

<div class="main">

<section class="slider">
<%-- <%@ include file="/slider.jsp" %>   --%>
<%@ include file="/slider2.jsp" %>

</section>
<br>
<br>
<br>
<br>

<!-- 
<a href="qnaList.do">QnaTest</a> -->
<br>
<div id="insta">
<p style="font-size:30px; font-weight:600">#INSTAGRAM</p><br>
<img src="images/insta_mini.png"><span style="clear:both;font-size:15px; font-weight:600;"> hairrang_official</span><br><br>
<%@ include file="insta.jsp" %>
<br><br>
<div class="more"><a href="http://instagram.com/hairrang_official"  target="_blank">MORE</a></div>
<br><br><br><br><br>
</div>
</div>
<%@ include file="footer.jsp" %>   