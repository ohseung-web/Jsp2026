<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		 Connection con = null;
		 PreparedStatement pstmt = null;
	    
	    // select문 담는 ResultSet객체 변수 생성
	    ResultSet rs = null;
	    
	    // DB접속 정보 설정
	    String driver = "com.mysql.cj.jdbc.Driver"; //JDBC드라이버
		// DB URL(스키마 이름 : jspdb)
		String url ="jdbc:mysql://localhost:3306/jspdb?serverTimezone=UTC&useSSL=false";
	    String user ="root"; //DB계정 아이디
	    String password = "1234";//DB계정 비밀번호
	    
	
	%>
</body>
</html>