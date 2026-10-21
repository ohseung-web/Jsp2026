<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" %>
    <%@ page import="java.sql.*" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인 회원 정보</title>
</head>
<body>
 <h2> 개인 회원 정보 </h2>
 <%
        request.setCharacterEncoding("utf-8");
 
        // MemberList.jsp에서 a태그에서 get방식으로 넘긴 id추출
        String id = request.getParameter("id");
 
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
	    
	    try{
	    	Class.forName(driver);
	    	con = DriverManager.getConnection(url, user, password);
	    	
	    	// 1명에 관련된 자료만 select문으로 검색
	    	String sql ="select * from member where id=?";
	    	pstmt = con.prepareStatement(sql);
	    	pstmt.setString(1, id);
	    	rs = pstmt.executeQuery();
	    	
	    	if(rs.next()){
	%>
		   <table width="500" border="1">
 			<tr height="50">
 				<td align="center" width="150">아이디</td>
 				<td width="350"><%= id %></td>
 			</tr>
 			<tr height="50">
 				<td align="center" width="150">email</td>
 				<td width="350"><%= rs.getString("email") %></td>
 			</tr>
 			<tr height="50">
 				<td align="center" width="150">전화번호</td>
 				<td width="350"><%= rs.getString("tel") %></td>
 			</tr>
 			<tr height="50">
 				<td align="center" width="150">관심분야</td>
 				<td width="350"><%= rs.getString("hobby") %> </td>
 			</tr>
 			<tr height="50">
 				<td align="center" width="150">직업</td>
 				<td width="350"><%= rs.getString("job") %></td>
 			</tr>
 			<tr height="50">
 				<td align="center" width="150">연령</td>
 				<td width="350"><%= rs.getString("age") %></td>
 			</tr>
 			<tr height="50">
 				<td align="center" width="150">남기는 말</td>
 				<td width="350"><%= rs.getString("info") %></td>
 			</tr>
 		</table>
 		<a href="MemberList.jsp">회원 목록으로</a>
	<%  
	   }
	    }catch(Exception e){
	    	e.printStackTrace();
	    }finally{
	    	if( rs != null){
	    		try{
	    			rs.close();
	    		}catch(Exception e){}
	    	}
	    	if( con != null){
	    		try{
	    			con.close();
	    		}catch(Exception e){}
	    	}
	    	if( pstmt != null){
	    		try{
	    			pstmt.close();
	    		}catch(Exception e){}
	    	}
	    }
%>  

</body>
</html>