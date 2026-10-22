<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
 <%@ page import ="java.sql.*" %>
 <%@ include file="db_conn.jsp" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	    request.setCharacterEncoding("utf-8");
	    String carNo = request.getParameter("carNo");   // 선택한 차량번호 (처음 접속 시 null)
    %>
	
	<h3>차량별주행조회</h3>
	
	<form name="carFrm" method="get" action="index.jsp">
	    <input type="hidden" name="page" value="carDrive">
	        <select name="carNo">
	            <option value="">차량선택</option>
	        </select>
	</form>        
	
</body>
</html>