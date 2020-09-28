<%@page import="hairrang_web.ds.JndiDs"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="../header.jsp" %>  
	<br>
	<br>
<style>
body {text-align:Center;}
img {margin-bottom:-6px;}

</style>
<body>
<section id="slider">
<%@ include file="../slider.jsp" %>  
</section>
<br>
<br>
<h1>임시 첫페이지</h1>
con = <%=JndiDs.getConnection() %>
<a href="QnaList.do">QnaTest</a>
<br>
<p style="font-size:30px; font-weight:600">#INSTAGRAM</p><br>
<img src="images/insta_mini.png"><span style="clear:both;font-size:15px; font-weight:600;"> hairrang_official</span><br><br>
<%@ include file="../insta.jsp" %> 
<br>
최근4개까지 나오고 더보기버튼으로 인스타로 이동<br>
내용<br>
내용<br>
내용<br>
내용<br>
내용
<br><br>
<br>
<br>
</body>
<%@ include file="../footer.jsp" %>   