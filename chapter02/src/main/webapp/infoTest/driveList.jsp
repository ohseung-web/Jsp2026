<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="java.sql.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	    
	    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
	    SimpleDateFormat sf02 = new SimpleDateFormat("yyyy년MM월dd일");
	    /* 숫자 세자리마다, 콤마, ￦ 표시 출력 */
	    DecimalFormat df = new DecimalFormat("#,##0");
	    DecimalFormat df02 = new DecimalFormat("￦#,##0");
	%>
	<h3> 주행내역조회 </h3>
	<table class="list">
	   <tr>
	       <th>주행일자</th>
	       <th>차량번호</th>
	       <th>모델</th>
	       <th>출발km</th>
	       <th>도착km</th>
	       <th>부서명</th>
	       <th>주유금액</th>
	   </tr>
	
	<%
		try{
			
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			String sql ="select d.DRV_DATE, d.CAR_NO, C.CAR_MODEL, d.DRV_START, d.DRV_END,p.DEPT_NAME,d.DRV_MONEY " 
					     + "from TBL_DRIVE d "
					     + "inner join TBL_CAR c on d.CAR_NO = c.CAR_NO "
					     + "inner join TBL_DEPT p on d.DEPT_CODE = p.DEPT_CODE "
					     + "order by d.CAR_NO asc";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
	  %>
	  		<tr>
	  			<td><%=sf02.format(sf.parse(rs.getString("d.DRV_DATE"))) %></td>
	  			<td><%= rs.getString("d.CAR_NO") %></td>
	  			<td><%= rs.getString("c.CAR_MODEL") %></td>
	  			<td><%= df.format(rs.getInt("d.DRV_START")) %></td>
	  			<td><%= df.format(rs.getInt("d.DRV_END")) %></td>
	  			<td><%= rs.getString("p.DEPT_NAME") %></td>
	  			<td><%= df02.format(rs.getInt("d.DRV_MONEY")) %></td>
	  		</tr>
	  		
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
	
	
	</table>
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>