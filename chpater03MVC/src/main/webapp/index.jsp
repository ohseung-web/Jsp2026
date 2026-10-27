<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인화면</title>
<link rel="stylesheet" href="style/index02.css"> 
</head>
<body>
 <%
    String section = request.getParameter("section");
    if(section == null){
    	 section = "section.jsp";
    } 
 %>
 <div class="container">
 	<jsp:include page="header.jsp" />
 	 	<section>
 	 		<jsp:include page="<%=section %>" />
 	 	</section>
 	<jsp:include page="footer.jsp" /> 	
 </div>
 
</body>
</html>