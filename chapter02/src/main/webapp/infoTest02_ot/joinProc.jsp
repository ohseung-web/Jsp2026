<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="db_conn.jsp" %>
<%
  request.setCharacterEncoding("UTF-8");
  boolean ok = false;

  try {
    Class.forName(driver);
    con = DriverManager.getConnection(url, user, password);
    String sql = "INSERT INTO member_tbl_02 (custno, custname, phone, address, joindate, grade, city) "
               + "VALUES (?, ?, ?, ?, ?, ?, ?)";
    pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, Integer.parseInt(request.getParameter("custno")));
    pstmt.setString(2, request.getParameter("custname"));
    pstmt.setString(3, request.getParameter("phone"));
    pstmt.setString(4, request.getParameter("address"));
    pstmt.setString(5, request.getParameter("joindate"));
    pstmt.setString(6, request.getParameter("grade"));
    pstmt.setString(7, request.getParameter("city"));
    
    ok = pstmt.executeUpdate() > 0;
    
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
  alert("회원등록이 완료되었습니다!");
  location.href = "memberForm.jsp";
<% } else { %>
  alert("회원등록에 실패했습니다.");
  history.back();
<% } %>
</script>
