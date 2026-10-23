<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="java.sql.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보삭제</title>
<link rel="stylesheet" href="style/memberJoin.css">
</head>
<body>
		<%
		    request.setCharacterEncoding("utf-8");
		    String id = request.getParameter("id");
		%>
		<div class="container">
		    <h2 align="center">회원 정보 삭제 하기</h2>
		    <form action="MemberDeleteProc.jsp" method="post">
		        <input type="hidden" name="id" value="<%= id %>">
		        <table width="400" border="1">
		            <tr height="50">
		                <td align="center" width="150">아이디</td>
		                <td width="250"><%= id %></td>
		            </tr>
		            <tr height="50">
		                <td align="center" width="150">패스워드</td>
		                <td width="250"><input type="password" name="pw" placeholder="본인 확인용 비밀번호"></td>
		            </tr>
		            <tr height="50">
		                <td align="center" colspan="2">
		                    <input type="submit" value="회원 삭제하기">&nbsp;&nbsp;
		                    <input type="button" value="회원 전체보기"
		                           onclick="location.href='main.jsp?page=MemberList'">
		                </td>
		            </tr>
		        </table>
		    </form>
		</div>
</body>
</html>