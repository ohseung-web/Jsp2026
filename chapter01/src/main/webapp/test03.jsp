<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>오늘날짜와 현재시간 출력</h1>
	<%
		Date today = new Date();
		int year = today.getYear()+1900;
		int month = today.getMonth()+1;
		int day = today.getDate();
		int hour = today.getHours();
		int minute = today.getMinutes();
		int second = today.getSeconds();
	%>
	오늘날짜 : <%=year+"년 "+month+"월 "+day+"일" %><br/>
	현재시간 : <%=hour+":"+minute+":"+second %>
	
</body>
</html>