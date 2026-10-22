<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="java.sql.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>차량조회</title>
<link rel="stylesheet" href="css/main.css">
</head>
<body>
	<%
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
    
    // 자바에서 날짜 형식변경하는 클래스
    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
    SimpleDateFormat sf02 = new SimpleDateFormat("yyyy년MM월dd일");
	%>
	
	<h3>차량주행 정보</h3>
	<table width="700" border="1" class="list">
	   <tr height="40" align="center">
	   		<th>차량번호</th>
	   		<th>모델</th>
	   		<th>제조사</th>
	   		<th>구매일</th>
	   </tr>
	<%
	   try{
		   //DB 연결  => 드라이버 로드
		   Class.forName(driver);
           // DB연결
           con = DriverManager.getConnection(url, user, password);
           
           String sql = "select * from TBL_CAR";
           pstmt = con.prepareStatement(sql);
           // select문은 실행 executeQuery()메소드로 실행
           // select문은 ResultSet()객체에 담는다.
           rs = pstmt.executeQuery();
           
           while(rs.next()){ // rs.next()메소드는 다음이 존재하면 true, 없으면 false
	   %>
	       <tr height="40">
	       		<td align="center"><%= rs.getString("CAR_NO")  %></td>
	       		<td align="center"><%= rs.getString("CAR_MODEL")  %></td>
	       		<td align="center"><%= rs.getString("CAR_COMPANY")  %></td>
	       		<!-- 
	       		     format()는 Date형식이고, DB는 String이기 때문에
	       		     parse() : String -> Date => "20230101" => Date객체
	       		     format() : Date -> String => Date객체 => "2023년01월01일"
	       		 -->
	       		<td align="center"><%=sf02.format(sf.parse(rs.getString("CAR_DATE")))  %></td>
	       </tr>
	       
	   <% }	   
	   }catch(Exception e){
		   e.printStackTrace();
		   out.println("DB fail");
	   }finally{
		   if(rs != null){
			   try{
				   rs.close();
			   }catch(Exception e){}
		   }
		   if(con != null){
			   try{
				   con.close();
			   }catch(Exception e){}
		   }
		   if(pstmt != null){
			   try{
				   pstmt.close();
			   }catch(Exception e){}
		   }
	   }
	%>   
	</table>
	
</body>
</html>