<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
 <%@ page import ="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	    request.setCharacterEncoding("utf-8");
	    String carNo = request.getParameter("carNo");//선택하지 않은 처음은 null이다.
	
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
	<h3>차량별주행조회</h3>
	<form action="index.jsp" method="get" name="carform">
		<input type="hidden" name="page" value="carDrive" >
		<select name="carNo">
			<option>차량선택</option>
			<option value="10가0001" <%="10가0001".equals(carNo)?"selected":"" %> >[10가001]</option>
			<option value="10가0002" <%="10가0002".equals(carNo)?"selected":"" %> >[10가002]</option>
			<option value="10가0003" <%="10가0003".equals(carNo)?"selected":"" %> >[10가003]</option>
			<option value="10가0004" <%="10가0004".equals(carNo)?"selected":"" %> >[10가004]</option>
			<option value="10가0005" <%="10가0005".equals(carNo)?"selected":"" %> >[10가005]</option>
		</select>
		<input type="button" value="조회" onclick="chkform()">
	</form>
	<!-- null 처리하는 if문 -->
	<%
	 	if(carNo != null && !carNo.isEmpty()){
	%>
	<table class="list">
	  <tr>
	  	<th>주행일자</th>
	  	<th>출발km</th>
	  	<th>도착km</th>
	  	<th>운행거리</th>
	  	<th>부서명</th>
	  	<th>주유금액</th>
	  </tr>
	<%
		try{
			
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			
			String sql ="select d.DRV_DATE, d.DRV_START, d.DRV_END, (d.DRV_END-d.DRV_START) as ch, "
					    +"p.DEPT_NAME, d.DRV_MONEY "
					    +"from tbl_dept p "
					    +"inner join tbl_drive d on d.DEPT_CODE = p.DEPT_CODE "
					    +"where d.CAR_NO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, carNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
		%>
		   <tr>
		   		<td><%= sf02.format(sf.parse(rs.getString("d.DRV_DATE"))) %></td>
		   		<td><%= rs.getInt("d.DRV_START") %></td>
		   		<td><%= rs.getInt("d.DRV_END") %></td>
		   		<td><%= rs.getInt("ch") %></td>
		   		<td><%= rs.getString("p.DEPT_NAME") %></td>
		   		<td><%= rs.getInt("d.DRV_MONEY") %></td>
		   </tr>  
		<%}
		}catch(Exception e){
			e.printStackTrace();
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
	<%} %>
	
	<script type="text/javascript">
	   function chkform(){
		   let f = document.carform;
		   f.submit();
	   }
	</script>
	
	
	
	
</body>
</html>