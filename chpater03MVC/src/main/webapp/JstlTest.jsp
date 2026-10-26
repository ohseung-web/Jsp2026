<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL Test</title>
</head>
<body>

 <c:if test="${4 > 3 }">
 	<p>응 ~ 맞아</p>
 </c:if>
 
</body>
</html>