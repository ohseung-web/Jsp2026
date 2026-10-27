<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB없는 회원 가입</title>
</head>
<body>
	<div id="testWrap">
		<h2>기본 회원가입</h2>
		<!-- form의 action속성의 값은 서블릿 매핑주소이다. -->
		<form action="Mproc.do" method="post">
			<table width="400" border="1">
				<tr height="40px">
					<td width="150">아이디</td>
					<td width="250">
					  <input type ="text" name="id">
					</td>
				</tr>
				<tr>	
					<td>비밀번호</td>
					<td width="250">
					  <input type ="password" name="pass">
					</td>
			    </tr>	
			    <tr>	
					<td>이메일</td>
					<td width="250">
					  <input type ="email" name="email">
					</td>
				</tr>
				<tr>	
					<td>전화번호</td>
					<td width="250">
					  <input type ="tel" name="tel">
					</td>
			   <tr>	
			   <tr>	
					<td>주소</td>
					<td width="250">
					  <input type ="text" name="address">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="가입">
						<input type="reset" value="취소">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>