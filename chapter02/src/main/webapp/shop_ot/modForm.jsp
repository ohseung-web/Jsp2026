<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="db_conn.jsp" %>
<%
  request.setCharacterEncoding("utf-8");
  String custno = request.getParameter("custno");
  String custname = "", phone = "", address = "", joindate = "", grade = "", city = "";

  try {
    Class.forName(driver);
    con = DriverManager.getConnection(url, user, password);
    String sql = "SELECT custname, phone, address, DATE_FORMAT(joindate, '%Y-%m-%d') AS jd, grade, city "
               + "FROM member_tbl_02 WHERE custno = ?";
    pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, Integer.parseInt(custno));
    rs = pstmt.executeQuery();
    if (rs.next()) {
      custname = rs.getString("custname");
      phone    = rs.getString("phone");
      address  = rs.getString("address");
      joindate = rs.getString("jd");
      grade    = rs.getString("grade");
      city     = rs.getString("city");
    }
  } finally {
    try {
      if (rs != null) rs.close();
      if (pstmt != null) pstmt.close();
      if (con != null) con.close();
    } catch (Exception e) { e.printStackTrace(); }
  }
%>
<jsp:include page="header.jsp" />
<section>
  <h2>홈쇼핑 회원 정보 수정</h2>
  <form name="frm" method="post" action="modProc.jsp" onsubmit="return checkForm()">
    <table class="form">
      <tr><th>회원번호</th><td><input type="text" name="custno" value="<%= custno %>" readonly></td></tr>
      <tr><th>회원성명</th><td><input type="text" name="custname" value="<%= custname %>" maxlength="20"></td></tr>
      <tr><th>회원전화</th><td><input type="text" name="phone" value="<%= phone %>" maxlength="13"></td></tr>
      <tr><th>회원주소</th><td><input type="text" name="address" value="<%= address %>" size="40" maxlength="60"></td></tr>
      <tr><th>가입일자</th><td><input type="text" name="joindate" value="<%= joindate %>" maxlength="10"></td></tr>
      <tr><th>고객등급[A:VIP, B:일반, C:직원]</th><td>
        <select name="grade">
          <option value="">선택</option>
          <option value="A" <%= "A".equals(grade) ? "selected" : "" %>>[A]VIP</option>
          <option value="B" <%= "B".equals(grade) ? "selected" : "" %>>[B]일반</option>
          <option value="C" <%= "C".equals(grade) ? "selected" : "" %>>[C]직원</option>
        </select></td></tr>
      <tr><th>도시코드</th><td><input type="text" name="city" value="<%= city %>" maxlength="2"></td></tr>
      <tr><td colspan="2" class="btn-area">
        <input type="submit" value="수 정">
        <input type="button" value="조 회" onclick="location.href='memberForm.jsp'">
      </td></tr>
    </table>
  </form>
</section>
<script src="js/check.js"></script>
<jsp:include page="footer.jsp" />
