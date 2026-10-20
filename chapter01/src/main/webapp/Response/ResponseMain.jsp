<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리다이렉트</title>
</head>
<body>
     <h2> 리다이렉트 페이지 </h2>
     <%
         request.setCharacterEncoding("utf-8");
         String id = request.getParameter("id");
     %>
     <p><%= id %>님 환영합니다.</p>
</body>
</html>