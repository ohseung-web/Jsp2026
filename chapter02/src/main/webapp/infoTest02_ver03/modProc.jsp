<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="db_conn.jsp" %>
<% 
	request.setCharacterEncoding("utf-8");
    /* 데이터 타입꼭 정확하게 DB와 일치하기  */
    int custno = Integer.parseInt(request.getParameter("custno"));
    String custname = request.getParameter("custname");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String joindate = request.getParameter("joindate");
    String grade = request.getParameter("grade");
    String city = request.getParameter("city");
    
    /* 수정성공/실패 메시지 변수 */
    boolean updateMsg = false;
    
    try{
    	Class.forName(driver);
    	con = DriverManager.getConnection(url, user, password);
    	/* 업데이트 sql => update 테이블이름 set 수식 (a=b) where 조건  */
    	String sql ="update member_tbl_02 set custname=?, phone=?, address=?, "
    			    +"joindate=?, grade=?, city=? where custno=? ";
    	pstmt = con.prepareStatement(sql);
    	
    	/* ?에 대응하는 set값을 정의 한다. 단, ?는 반드시 개수만큼 대응한다.
    	   왼쪽부터 순서대로 1, 2,3,......이다.		
    	*/
    	pstmt.setString(1, custname);
    	pstmt.setString(2, phone);
    	pstmt.setString(3, address);
    	pstmt.setString(4, joindate);
    	pstmt.setString(5, grade);
    	pstmt.setString(6, city);
    	pstmt.setInt(7, custno);
    	
    	/* update, delete, insert는 실행할명령어 executeUpdate() */
    	pstmt.executeUpdate(); // 쿼리 실행함
           			    		
    	updateMsg = true;// try안세서 업데이터가 실행된 상태이므로 메시는 true로 정의 한다.
    	
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
   if(<%=updateMsg%>){
	  alert("회원정보 수정 완료함!");
	  location.href="memberForm.jsp";
	}else {
	  alert("회원정보 수정 실패!");
	  history.go(-1);
	};
	
	<%-- <%if(updateMsg){%>
	  alert("회원정보 수정 완료함!");
	  location.href="memberForm.jsp";
	<%}else {%>
	  alert("회원정보 수정 실패!");
	  history.go(-1);
	<%}%>; --%>
</script>