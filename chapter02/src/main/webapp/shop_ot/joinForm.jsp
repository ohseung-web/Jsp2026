<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="db_conn.jsp" %>
<%
  int nextNo = 100001;   // 자동생성 회원번호

  try {
    Class.forName(driver);
    con = DriverManager.getConnection(url, user, password);
    String sql = "SELECT ifnull(max(custno),10000)+1 as cu FROM member_tbl_02";   // 최대 회원번호 + 1
    pstmt = con.prepareStatement(sql);
    rs = pstmt.executeQuery();
    // if (rs.next()) nextNo = rs.getInt(1);
    if (rs.next()) nextNo = rs.getInt("cu");
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
  <h2>홈쇼핑 회원등록</h2>
  <form name="frm" method="post" action="joinProc.jsp" onsubmit="return checkForm()">
    <table class="form">
      <tr>
          <th>회원번호(자동생성)</th>
          <td><input type="text" name="custno" value="<%= nextNo %>" readonly></td>
      </tr>
      <tr><th>회원성명</th><td><input type="text" name="custname" maxlength="20"></td></tr>
      <tr><th>회원전화</th><td><input type="text" name="phone" maxlength="13"></td></tr>
      <tr><th>회원주소</th><td><input type="text" name="address" size="40" maxlength="60"></td></tr>
      <tr><th>가입일자</th><td><input type="text" name="joindate" maxlength="8"> 예) 20151202</td></tr>
      <tr><th>고객등급[A:VIP, B:일반, C:직원]</th><td>
        <select name="grade">
          <option value="">선택</option>
          <option value="A">[A]VIP</option>
          <option value="B">[B]일반</option>
          <option value="C">[C]직원</option>
        </select></td></tr>
      <tr><th>도시코드</th><td><input type="text" name="city" maxlength="2"></td></tr>
      <tr><td colspan="2" class="btn-area">
        <input type="submit" value="등 록">
        <input type="button" value="조 회" onclick="location.href='memberForm.jsp'">
      </td></tr>
    </table>
  </form>
</section>
<script src="js/check.js"></script>
<jsp:include page="footer.jsp" />
