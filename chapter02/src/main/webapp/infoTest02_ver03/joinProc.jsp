<%@page import="org.eclipse.jdt.internal.compiler.parser.RecoveredRequiresStatement"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="DBPKG.Util" %>

<% 
	request.setCharacterEncoding("utf-8");
    boolean msgChk = false; // 회원등록이될때 메시지 체크 변수
    
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try{
	     con =Util.getConnection();	 
		 
		 String sql ="insert into member_tbl_02 values(null,?,?,?,?,?,?) ";
		 pstmt = con.prepareStatement(sql);
		 
		 pstmt.setString(1,request.getParameter("custname"));
		 pstmt.setString(2,request.getParameter("phone"));
		 pstmt.setString(3,request.getParameter("address"));
		 pstmt.setString(4,request.getParameter("joindate"));
		 pstmt.setString(5,request.getParameter("grade"));
		 pstmt.setString(6,request.getParameter("city"));
		 
		 // msgChk를 위해서 insert, update, delete 실행후 int = 1
		 msgChk = pstmt.executeUpdate() > 0;
		 
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
<script>
  <% if(msgChk) { %>
  	alert("회원등록이 완료됨");
  	location.href ="memberForm.jsp";
  <%}else { %>
  	alert("회원등록이 실패");
  	history.go(-1);  
  <%}%>
</script>









