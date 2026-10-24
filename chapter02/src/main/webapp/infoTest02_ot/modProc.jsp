<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="db_conn.jsp" %>
<%
  request.setCharacterEncoding("UTF-8");

  String custname = request.getParameter("custname");
  String phone = request.getParameter("phone");
  String address = request.getParameter("address");
  String joindate = request.getParameter("joindate");
  String grade = request.getParameter("grade");
  String city = request.getParameter("city");
  int custno = Integer.parseInt(request.getParameter("custno"));

  boolean ok = false;

  try {
    Class.forName(driver);
    con = DriverManager.getConnection(url, user, password);
    String sql = "UPDATE member_tbl_02 SET custname=?, phone=?, address=?, "
               + "joindate=?, grade=?, city=? WHERE custno=?";
    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, custname );
    pstmt.setString(2, phone );
    pstmt.setString(3, address );
    pstmt.setString(4, joindate);
    pstmt.setString(5, grade);
    pstmt.setString(6, city);
    pstmt.setInt(7, custno);
    pstmt.executeUpdate();
    
    ok = true;
    
  } catch (Exception e) {
    e.printStackTrace();
  } finally {
    try {
      if (rs != null) rs.close();
      if (pstmt != null) pstmt.close();
      if (con != null) con.close();
    } catch (Exception e) { e.printStackTrace(); }
  }
%>
<script>
<% if (ok) { %>
  alert("회원정보 수정이 완료되었습니다!");
  location.href = "memberForm.jsp";
<% } else { %>
  alert("회원정보 수정에 실패했습니다.");
  history.back();
<% } %>
</script>
