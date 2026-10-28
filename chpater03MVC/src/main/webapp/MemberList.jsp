<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원전체목록</title>
</head>
<body>
	<div id="listwrap">
		<h2 align="center"> 모든 회원 보기 </h2>
		<table class="listtable">
			<tr height="40">
				<td align="center" width="50">아이디</td>
				<td align="center" width="200">이메일</td>
				<td align="center" width="150">전화</td>
				<td align="center" width="150">취미</td>
				<td align="center" width="150">직업</td>
 				<td align="center" width="100">나이</td>
			</tr>
			<c:forEach var="mdto" items="${alist }" >
			 <tr height="40">
			 	<!-- mdto.id는 MemberDTO의 getId()를 찾아서 실행함 -->
			 	<td align="center" width="50">${mdto.id }</td>
				<td align="center" width="200">${mdto.email}</td>
				<td align="center" width="150">${mdto.tel}</td>
				<td align="center" width="150">${mdto.hobby}</td>
				<td align="center" width="150">${mdto.job}</td>
 				<td align="center" width="100">${mdto.age}</td>
			 </tr>	
			</c:forEach>
		</table>
	</div>
</body>
</html>