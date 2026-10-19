<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2> 나는 forward 페이지 </h2>
	<%
        request.setCharacterEncoding("utf-8");
        
        String id = request.getParameter("id");
        String pass = request.getParameter("pass");
    %> 
    
    <h3>당신의 아이디는 <%= id %>이고, 비밀번호는 <%= pass %>이다.</h3>
</body>
</html>