<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" %>
<%@ page import ="java.sql.*" %>   
<%@ include file="db_conn.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<link rel="stylesheet" href="css/main.css">
</head>
<body>
	<%
		 /* Connection con = null; */
		 /* PreparedStatement pstmt = null;
	    
	    // select문 담는 ResultSet객체 변수 생성
	    ResultSet rs = null;
	    
	    // DB접속 정보 설정
	    String driver = "com.mysql.cj.jdbc.Driver"; //JDBC드라이버
		// DB URL(스키마 이름 : jspdb)
		String url ="jdbc:mysql://localhost:3306/jspdb?serverTimezone=UTC&useSSL=false";
	    String user ="root"; //DB계정 아이디
	    String password = "1234";//DB계정 비밀번호 */
	    
	    /* 숫자 세자리마다, 콤마, ￦ 표시 출력 */
	    DecimalFormat df = new DecimalFormat("#,##0");
	    DecimalFormat df02 = new DecimalFormat("￦#,##0");
	%>
	<h3> (부서별)주행통계 </h3>
	<table class="list">
	   <tr>
	       <th>부서코드</th>
	       <th>부서명</th>
	       <th>총운행거리</th>
	       <th>총주유금액</th>
	   </tr>
	
	<%
		try{
			
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			String sql ="select p.DEPT_CODE, p.DEPT_NAME, "
					    + "sum(d.DRV_END-d.DRV_START) as t, sum(d.DRV_MONEY) as m "
					    + "from TBL_DRIVE d "
					    + "inner join TBL_DEPT p on d.DEPT_CODE = p.DEPT_CODE "
					    + "group by p.DEPT_CODE ";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
	  %>
	  		<tr>
	  			<td><%= rs.getString("p.DEPT_CODE") %></td>
	  			<td><%= rs.getString("p.DEPT_NAME") %></td>
	  			<td><%= rs.getInt("t") %></td>
	  			<td><%= df02.format(rs.getInt("m")) %></td>
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
</body>
</html>