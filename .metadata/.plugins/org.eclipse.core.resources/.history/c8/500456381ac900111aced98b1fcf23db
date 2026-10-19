<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<!-- 구구단 2단 ~ 9단까지 모두 출력할 것  -->
		<h1>구구단</h1>
		<table border="1">
		<!-- 2단.... -->
		<tr>
			<% for(int i=2; i<=9; i++){ %>
			   <th><%= i %>단</th>
			<%} %>
		</tr>
		   
		<% for(int i=1; i<=9; i++){%>
		<tr>
			 <% for(int j=2; j<=9; j++){
		%>
		  	<td><%=j%>*<%=i%>=<%= i*j %></td>
		<% }%>
		</tr>
		<% } %>
		
		</table>
</body>
</html>