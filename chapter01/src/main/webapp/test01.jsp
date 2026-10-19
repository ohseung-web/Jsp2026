<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>1부터 10까지 출력</h1>
	<% for(int i=1; i<=10; i++){ %>
	<!-- 표현식은 데이터를 출력할때 사용하는 스크립트 문법중 하나이다. -->
	<%= i %>
	<% } %>
</body>
</html>