<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2> 두번째 세션 페이지</h2>
	<%
	   String seName03  = (String)session.getAttribute("seName");
	%>
	<p><%= seName03 %></p>
</body>
</html>