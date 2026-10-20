<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2> 커피메뉴 </h2>
	<form action="coffeeProc.jsp" method="get">
		<ul>
			<li>
				<input type="radio" name="coffee" id="ame" value="아메리카노">
				<label for="ame">아메리카노 (3000원)</label>
			</li>
			<li>
				<input type="radio" name="coffee" id="cafe" value="카페라떼">
				<label for="cafe">카페라떼 (3300원)</label>
			</li>
			<li>
				<input type="radio" name="coffee" id="asofress" value="에스프레소">
				<label for="asofress">에스프레소 (2500원)</label>
			</li>
			<li>
				<input type="radio" name="coffee" id="ale" value="얼그레이">
				<label for="ale">얼그레이 (3500원)</label>
			</li>
		</ul>
		<label for="quantity">수량 :</label>
		<input type="number" id="quantity" name="quantity"><br/>
		<label for="money">입금액 :</label>
		<input type="number" id="money" name="money">
		<input type="submit" value="주문처리">
	</form>
</body>
</html>