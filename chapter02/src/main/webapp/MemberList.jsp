<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" %>
    <%@ page import="java.sql.*" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 전체 목록보기</title>
</head>
<body>
 <h2> 가입한 회원 전체목록</h2>
 <%
  		Connection con = null;
	    PreparedStatement pstmt = null;
	    
	    // select문 담는 ResultSet객체 변수 생성
	    ResultSet rs = null;
	    int count = 0; // 회원수 세는 변수
	    
	    // DB접속 정보 설정
	    String driver = "com.mysql.cj.jdbc.Driver"; //JDBC드라이버
		// DB URL(스키마 이름 : jspdb)
		String url ="jdbc:mysql://localhost:3306/jspdb?serverTimezone=UTC&useSSL=false";
	    String user ="root"; //DB계정 아이디
	    String password = "1234";//DB계정 비밀번호
%>  
	    <!-- 테이블 태그 -->
	    <table width="700" border="1">
	      <tr height="50" align="center">
	        <td>번호</td>
	        <td>아이디</td>
	        <td>이메일</td>
	        <td>전화번호</td>
	        <td>관심분야</td>
	        <td>직업</td>
	        <td>연령</td>
	        <td>남기는 말</td>
	        <td>상세보기</td>
	      </tr>
<%	 
	 
	    
	    try{
	    	
	    	// 드라이버 로딩
	    	Class.forName(driver);
	    	// DB연결
	        con = DriverManager.getConnection(url, user, password);
	    	
	    	// 가입한 회원 모든정보 검색 select문이용
	    	String sql ="select * from member";
	    	pstmt = con.prepareStatement(sql);
	    	// resultSet 객체에 담기 => sql문의 실행결과를 담는다.
	    	// kjb1045	1234	k@naver.com	010-1111-1111	등산 영화 	의사	40대	테스트
									
	    	rs = pstmt.executeQuery();
	    	// rs에 담긴 정보를 추출하는 메소드 => rs.getString()
	    	// rs의 데이터가 1개이상이므로 반복문이 필요
	    	while(rs.next()){
	    		count++;
	 %>  
	     <!-- select문으로 검색한 정보가 출력되는 <tr></tr>필요  -->
	     <tr height="50" align="center">
	        <td><%= count %></td>
	        <td><%= rs.getString("id") %></td>
	        <td><%= rs.getString("email") %></td>
	        <td><%= rs.getString("tel") %></td>
	        <td><%= rs.getString("hobby") %></td>
	        <td><%= rs.getString("job") %></td>
	        <td><%= rs.getString("age") %></td>
	        <td><%= rs.getString("info") %></td>
	        <!-- get방식으로 MmberDetail.jsp에 id를 떠넘겨야 한다. -->
	        <!-- get방식으로 데이터를 넘길때 조건이 여러개인 경우 : main.jsp?조건&조건&조건 -->
	        <td><a href="main.jsp?page=MemberDetail&id=<%= rs.getString("id") %>">상세보기</a></td>
	     </tr>   	 
	  <% }
	    }catch(Exception e){
	    	e.printStackTrace();
	    }finally{
	    	// 자원 종료한다.
	    	if(rs != null) {
	    		try{
	    			rs.close();
	    		}catch(Exception e){}}
	    	if(con != null) {
	    		try{
	    			con.close();
	    		}catch(Exception e){}}
	    	if(pstmt != null) {
	    		try{
	    			pstmt.close();
	    		}catch(Exception e){}}
	    }
	        
     %>
     </table> 
     <a href="main.jsp?page=MemberJoin">회원가입으로 가기</a> 
  
</body>
</html>