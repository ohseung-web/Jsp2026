<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

	<header>
		<div class="headerWrap">
			<table width="1000" id="navi">
				<tr height="70">
					<td colspan="4" align="left">
						<a href="index.jsp">
							<img alt="로고" src="img/sk_logo.png" height="65">
						</a>
					</td>
				</tr>
				<tr height="50">
					<td align="center" width="200">
						<a href="#" class="nav">예약하기</a>
					</td>
					<td align="center" width="200">
						<a href="#" class="nav">예약확인</a>
					</td>
					<td align="center" width="200">
						<a href="BoardListCon.do" class="nav">게시판</a>
					</td>
					
<%--					로그인된 상태의 메뉴 : 일반=> MyPage k님 [로그아웃]
					                  admin => 회원관리 관리자님[로그아웃] 메뉴 수정
					--%>
					<c:choose>
						<%-- 로그인된 상태 , sessionScope(세션영역).id--%>
					  <c:when test="${not empty sessionScope.id  }">
					   <c:choose>
					      <c:when test="${sessionScope.id == 'admin' }">
						    <td align="center" width="200">
						    	<a href="MemberListCon.do" class="nav">회원관리</a>
						    </td>
						  </c:when>
						  <c:otherwise>
						  	 <td align="center" width="200">
						    	<!-- <a href="index.jsp?section=member/Mypage.jsp" class="nav">MyPage</a> -->
						    	<a href="MyPage.do" class="nav">MyPage</a>
						    </td>
						  </c:otherwise>  
					   </c:choose> 
					     <td align="center" width="200">
						    	<span class="nav">${sessionScope.id }님</span>
						 </td>
					    <td align="center" width="200">
					    	<a href="logoutProc.do" class="nav">로그아웃</a>
					    </td>
					  </c:when>	
					  
					<%-- 로그인이 안된상태	 --%>				 
					<c:otherwise> 
						<td align="center" width="200">
							<a href="index.jsp?section=member/MemberJoin.jsp" class="nav">회원가입</a>
						</td>
						<td align="center" width="200">
							<a href="index.jsp?section=login/loginForm.jsp" class="nav">로그인</a>
						</td>
					</c:otherwise>
			     </c:choose> 		
			     
				</tr>
			</table>
		</div>
	</header>
