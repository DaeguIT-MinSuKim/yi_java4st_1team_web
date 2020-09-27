<%@page import="hairrang_web.ds.JndiDs"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
</head>
<body>
con = <%=JndiDs.getConnection() %>
</body>
</html>