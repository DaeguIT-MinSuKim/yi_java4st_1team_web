<%@page import="hairrang_web.ds.JndiDs"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
</head>
<body>
<h1>임시 첫페이지</h1>
con = <%=JndiDs.getConnection() %>
<a href="QnaList.do">QnaTest</a>
</body>
</html>