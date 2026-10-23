<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원수정</title>
</head>
<body>
<%
		
        request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");

		/* 이메일, 전화번호만 수정 하려고 함 */
		String email ="";
		String tel ="";
		/* 넘겨온 아이디가 DB와 일치하는지 체크하는 체크키 */
		boolean idChk = false;
		
        Connection con = null;
		PreparedStatement pstmt = null;
		
		// select문 담는 ResultSet객체 변수 생성
		ResultSet rs = null;
		
		// DB접속 정보 설정
		String driver = "com.mysql.cj.jdbc.Driver"; //JDBC드라이버
		// DB URL(스키마 이름 : jspdb)
		String url ="jdbc:mysql://localhost:3306/jspdb?serverTimezone=UTC&useSSL=false";
		String user ="root"; //DB계정 아이디
		String password = "1234";//DB계정 비밀번호
		
		System.out.println("1번, 요기까지 왔니?");
		try{
			System.out.println("2번, 요기까지 왔니?");
			// 드라이브 연결
			Class.forName(driver);
			// DB연동
			con = DriverManager.getConnection(url, user, password);
			// 쿼리문
			String sql ="select id,email,tel from member where id=?";
			pstmt = con.prepareStatement(sql);
			// sql문의 ?에 대응하는 부분
			pstmt.setString(1,id);
			// select문은 ResultSet()객체에 담아라
			rs = pstmt.executeQuery();
			
			// 현재 rs는 id정보가 같은 한 사람의 정보만 가진다.
			if(rs.next()){
				/* id를 찾았다는 부분 */
				idChk = true;
				email = rs.getString("email");
				tel = rs.getString("tel");
			}
             			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("3번, 요기까지 왔니?");
		}finally{
			if(rs != null){
				try{
			          rs.close();		
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			if(con != null){
				try{
					con.close();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			if(pstmt != null){
				try{ 
			    	pstmt.close();	
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
		
%>
	<h3> 개인 회원정보 수정</h3>
	<form action="MemberUpdateProc.jsp" method="post">
	<!-- MemberUpdateForm에서 MemberUpdateProc로 넘길때 id가 input에 담긴 값이 아니므로
	     id를 input의 hidden으로 넘겨주어야 한다.
	  -->
	    <input type="hidden" name="id" value="<%=id%>">
		<table width="400" border="1">
			<tr height="50">
				<td align="center" width="150">아이디</td>
				<!-- 넘겨받은 id는 수정대상이 아니다. -->
				<td width="250"><%=id %></td>
			</tr>
			<tr height="50">
				<td align="center" width="150">이메일</td>
				<td width="250">
					<input type="email" name="email" value="<%=email %>">
			</td>
			<tr height="50">
				<td align="center" width="150">전화</td>
				<td width="250">
					<input type="tel" name="tel" value="<%=tel %>">
			</td>
			<tr height="50">
				<td align="center" width="150">패스워드</td>
				<td width="250">
					<input type="password" name="pass2" placeholder="본인 비밀번호 입력">
			    </td>
			</tr>
			<tr height="50">
				<td align="center" colspan="2">					<input type="submit" value="회원 수정하기">&nbsp;
					<input type="button" value="회원 전체보기" onclick="location.href='main.jsp?page=MemberList'">&nbsp;
			    </td>
	        </tr>
		</table>
	</form>
</body>
</html>