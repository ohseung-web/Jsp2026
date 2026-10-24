<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="db_conn.jsp" %>
<jsp:include page="header.jsp" />
<section>
  <h2>고객등급별 매출 통계</h2>
  <table>
    <tr><th>고객등급</th><th>회원 수</th><th>매출 합계</th><th>매출 평균</th></tr>
<%
  try {
    Class.forName(driver);
    con = DriverManager.getConnection(url, user, password);
    // 회원별 매출 합계(t)를 먼저 구한 뒤 등급별로 집계
    String sql = "SELECT CASE grade WHEN 'A' THEN 'VIP' WHEN 'B' THEN '일반' ELSE '직원' END AS gname, "
               + "COUNT(*) AS cnt, SUM(t) AS total, AVG(t) AS average "
               + "FROM (SELECT m1.custno, m1.grade, SUM(m2.price) AS t "
               + "      FROM member_tbl_02 m1 INNER JOIN money_tbl_02 m2 ON m1.custno = m2.custno "
               + "      GROUP BY m1.custno, m1.grade) x "
               + "GROUP BY grade ORDER BY total DESC";
    pstmt = con.prepareStatement(sql);
    rs = pstmt.executeQuery();
    while (rs.next()) {
%>
    <tr>
      <td><%= rs.getString("gname") %></td>
      <td><%= rs.getInt("cnt") %></td>
      <td style="text-align:right"><%= String.format("₩%,d", rs.getLong("total")) %></td>
      <td style="text-align:right"><%= String.format("₩%,d", Math.round(rs.getDouble("average"))) %></td>
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
