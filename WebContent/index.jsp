<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>  

<br>
<br>
<style>
	body {text-align:Center;}
	img {margin-bottom:-6px;}
	
	.more {margin:0 auto; border:3px solid gray; width: 120px;}
	.more a { text-align:center;text-decoration:none; color:gray; font-size:20px; font-weight:bold;}

</style>
<section id="slider">
<%@ include file="/slider.jsp" %>  
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

<%@ include file="footer.jsp" %>   