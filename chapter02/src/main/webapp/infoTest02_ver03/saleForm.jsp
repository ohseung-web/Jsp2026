<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="db_conn.jsp" %>
<jsp:include page="header.jsp" />
<section>
	<h2>회원매출 조회</h2>
	<table>
		<tr>
			<th>회원번호</th>
			<th>회원성명</th>
			<th>고객등급</th>
			<th>매출</th>
		</tr>
<%
	String grade="";
    String gradeName ="";
    
    try{
    	 Class.forName(driver);
    	 con = DriverManager.getConnection(url, user, password);
    	 
    	 String sql ="select m.custno, m.custname, m.grade, sum(e.price) as total from member_tbl_02 m "
    			     +"inner join money_tbl_02 e on m.custno = e.custno "
    			     +"group by m.custno " 
    			     +"order by total desc"; 
    	 pstmt = con.prepareStatement(sql);
    	 rs = pstmt.executeQuery();
    	 
    	 while(rs.next()){
    		grade = rs.getString("m.grade");
    		if(grade.equals("A")) gradeName="VIP";
    		else if(grade.equals("B")) gradeName="일반";
    		else gradeName="직원";
 %>
     	<tr>
     		<td><%=rs.getInt("m.custno") %></td>
     		<td><%=rs.getString("m.custname") %></td>
     		<td><%=gradeName %></td>
     		<td><%=String.format("￦%,d", rs.getInt("total")) %></td>
     	</tr>   
 <%   		 
    	 }
    	 
    }catch(Exception e){
    	e.printStackTrace();
    }finally{
    	try{
    		if(rs != null) rs.close();
    		if(con != null) con.close();
    		if(pstmt != null) pstmt.close();
    	}catch(Exception e){e.printStackTrace();}
    }
%>		
	</table>
</section>
<jsp:include page="footer.jsp" />