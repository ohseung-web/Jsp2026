<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="style/login.css">

<div class="loginwrap">
  <h2>로그인</h2>
  <form action="loginProc.do">
  	<table width="300">
  		<tr height="40">
  			<td width="120">아이디</td>
  			<td width="180">
  				<input type="text" name="id" placeholder="아이디 입력">
  			</td>
  		</tr>
  		<tr height="40">
  			<td width="120">패스워드</td>
  			<td width="180">
  				<input type="password" name="pass" placeholder="패스워드 입력">
  			</td>
  		</tr>
  		<tr height="40">
  			<td colspan="2">
  				<input type="submit" value="로그인">
  			</td>
  		</tr>
  		
  	</table>
  </form>
</div>