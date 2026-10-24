<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="db_conn.jsp" %>
<jsp:include page="header.jsp" />
<section>
  <h2>회원목록조회/수정</h2>
  <table>
    <tr><th>회원번호</th><th>회원성명</th><th>전화번호</th><th>주소</th><th>가입일자</th><th>고객등급</th><th>거주지역</th></tr>
<%
  try {
    Class.forName(driver);
    con = DriverManager.getConnection(url, user, password);
    String sql = "SELECT custno, custname, phone, address, DATE_FORMAT(joindate, '%Y-%m-%d') AS jd, "
               + "CASE grade WHEN 'A' THEN 'VIP' WHEN 'B' THEN '일반' ELSE '직원' END AS gname, city "
               + "FROM member_tbl_02 ORDER BY custno";
    pstmt = con.prepareStatement(sql);
    rs = pstmt.executeQuery();
    while (rs.next()) {
%>
    <tr>
      <td><a class="link" href="modForm.jsp?custno=<%= rs.getInt("custno") %>"><%= rs.getInt("custno") %></a></td>
      <td><%= rs.getString("custname") %></td>
      <td><%= rs.getString("phone") %></td>
      <td><%= rs.getString("address") %></td>
      <td><%= rs.getString("jd") %></td>
      <td><%= rs.getString("gname") %></td>
      <td><%= rs.getString("city") %></td>
    </tr>
<%
    }
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
  </table>
</section>
<jsp:include page="footer.jsp" />
