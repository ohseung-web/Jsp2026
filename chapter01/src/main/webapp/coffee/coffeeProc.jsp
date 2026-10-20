<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커피메뉴 처리</title>
</head>
<body>
     <!-- 스크립트릿은 자바이다. 꼭꼭 기억하기  -->
	<%
	   request.setCharacterEncoding("utf-8");
	   
	   // 세자리마다 콤마 출력하는 DecimalFormat 객체를 인스턴스한다.
	   DecimalFormat de = new DecimalFormat("#,##0");
	   
	   String coffee = request.getParameter("coffee");
	   int price = 0; // 각 커피메뉴당 가격 담을 변수
	   int total = 0; // 총 주문 금액
	   
	   // Request 객체는 반환타입이 String이므로 정수타입으로 반환 불가능
	   // 정수타입으로 반환받으려면 파싱한다.
	   int quantity = Integer.parseInt(request.getParameter("quantity"));
	   int money = Integer.parseInt(request.getParameter("money"));
	   
	   // 메뉴별 커피 금액
	   if(coffee.equals("아메리카노")){
		  price = 3000;
	   }else if(coffee.equals("카페라떼")){
		  price = 3300;
	   }else if(coffee.equals("에스프레소")){
		  price = 2500;
	   }else{
		  price = 3500;
	   }
			   
	   total = quantity * price; //총금액
	%>
	<!-- 화면 출력 HTML 작성 -->
	<h2> 주문계산 결과 </h2>
	<ul>
		<li>커피종류 : <%= coffee %></li>
		<li>1개 가격 : <%= de.format(price) %>원</li>
		<li>수량 : <%= de.format(quantity) %></li>
		<li>총금액 : <%= de.format(total) %></li>
		<li>입금액 : <%= de.format(money) %></li>
		<li>거스름돈 : <%= de.format(money - total)%></li>
	</ul>
</body>	
</html>