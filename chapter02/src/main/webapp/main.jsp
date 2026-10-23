<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린팩토리</title>
<link rel="stylesheet" href="style/fooding.css">
</head>
<body>
	<%
	   request.setCharacterEncoding("utf-8");
	   String pageName = request.getParameter("page");
	   
	   String contentPage = "main.jsp";
	   
	   if("MemberJoin".equals(pageName)){
		   contentPage ="MemberJoin.jsp";
	   }else if("login".equals(pageName)){
		   contentPage ="login.jsp";
	   }else if("MemberList".equals(pageName)){
		   contentPage ="MemberList.jsp";
	   }else if("MemberDetail".equals(pageName)){
		   contentPage ="MemberDetail.jsp";
	   }else if("MemberUpdateForm".equals(pageName)){
		   contentPage ="MemberUpdateForm.jsp";
	   }else if("MemberDeleteProc".equals(pageName)){
		   contentPage ="MemberDeleteProc.jsp";
	   }else if("MemberDeleteForm".equals(pageName)){
		   contentPage ="MemberDeleteForm.jsp";
	   }
	
	%>
	<%@ include file="header.jsp" %>
	<section>
	  <% if(contentPage != "main.jsp"){ %>
	  <jsp:include page="<%=contentPage %>"></jsp:include>
	  <%}else { %>
	  <p>여기는 메인화면 입니다.</p>
	  <%} %>
	</section> 
	<%@ include file="footer.jsp" %>
	
</body>
</html>