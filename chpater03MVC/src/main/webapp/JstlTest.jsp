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

 <!-- c:if문은 조건을 한번만 지정할 수 있다. -->
 <c:if test="${4 > 3 }">
 	<p>응 ~ 맞아</p>
 </c:if>
 
 <c:set var="name">홍길동</c:set>
 <c:set var="age" value="25" />
 <!-- EL표현식을 이용하여 화면에 name변수를 출력할 수 있다. -->
 나의 이름은 ${name }
 <c:out value="${age }" />
 
 <h2>변수삭제</h2>
 <c:remove var="name"/>
 나의 이름은 <c:out value="${name }" /><br/>
 
 <!-- forEach => 자바의 확장for문과 쓰임새가 같다. -->
 <c:forEach var="i" begin="1" end="10" step="1">
 	${i }
 <!--  1부터 10까지 합 -->	
 <c:set var="sum" value="${sum+i }" />
 </c:forEach>
 <p>1 ~ 10까지 합 : ${sum }</p>
 
 <h2>문자열 분리</h2>
 <c:forTokens var="car" items="소나타-그렌저-아우디" delims="-" >
 	${car }
 </c:forTokens>
 
 <!-- 다중 if문 사용방법 -->
 <h2>다중 if문</h2>
 <c:set var="color" value="red,green,black,yellow,white" />
 <c:forEach var="arr"  items="${color }">
 	<c:choose>
 		<c:when test="${arr=='red' }">빨강</c:when>
 		<c:when test="${arr=='green' }">초록</c:when>
 		<c:when test="${arr=='black' }">검정</c:when>
 		<c:when test="${arr=='yellow' }">노랑</c:when>
 		<c:otherwise>파랑</c:otherwise>
 	</c:choose>
 </c:forEach>
 
</body>
</html>