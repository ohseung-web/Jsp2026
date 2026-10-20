<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>세션</title>
</head>
<body>
    <%
       String name = "shin";
       // session은 내장객체로 서버에서 정보(데이터)를 유지하다
       // setAttribute("텍스트", Object) => 저장
       // getAttribute("텍스트") => 추출
       session.setAttribute("seName", name);
       // 세션 만료시간
       session.setMaxInactiveInterval(10); // 10초간 유지 후 꺼짐
       
    %>
    <!-- get방식으로 떠넘기기 -->
    <a href="SessionName.jsp">세션네임 페이지로 이동</a>
</body>
</html>