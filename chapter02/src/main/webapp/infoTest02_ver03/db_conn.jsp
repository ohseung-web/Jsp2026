<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<%
		/* DB 접속 정보 */
		String driver = "com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jspdb?serverTimezone=UTC&useSSL=false";
		String user = "root";
		String password = "1234";
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
%>