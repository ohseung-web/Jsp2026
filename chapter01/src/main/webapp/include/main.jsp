<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>차량주행관리 프로그램</title>
<link rel="stylesheet" href="css/main_info.css">
</head>
<body>
		<%
			request.setCharacterEncoding("utf-8");
		
		    // nav.jsp의 a태그 main.jsp?page=cartList
		    String pageName = request.getParameter("page");
		    
		    // 메뉴를 클릭하지 않으면 기본화면인 home.jsp
		    String contentPage ="home.jsp";
		    
		    // 클릭한 메뉴의 page의 이름을 section에 보여준다
		    if("carList".equals(pageName)){
		    	contentPage = "carList.jsp";
		    }
		%>
	<div id="wrap">
		<!-- header.jsp include(포함)하기 -->
		<%@ include file="header.jsp" %>
		<!-- nav.jsp include하기 -->
		<%@ include file="nav.jsp" %>
		
		<!-- section 부분의 HTML -->
		<section>
			<jsp:include page="<%= contentPage %>"></jsp:include>
		</section>
		
		<!-- footer.jsp include(포함) -->
		<%@ include file="footer.jsp" %>
		
	</div>
</body>
</html>