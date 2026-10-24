<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="db_conn.jsp" %>

<jsp:include page="header.jsp" />
<section>
  <h2>홈쇼핑 회원등록</h2>
  <form name="frm" method="post" action="joinProc.jsp">
    <table class="form">
      <tr>
          <th>회원번호(자동생성)</th>
          <td><input type="text" name="custno" value="" readonly></td>
      </tr>
      <tr><th>회원성명</th><td><input type="text" name="custname" ></td></tr>
      <tr><th>회원전화</th><td><input type="text" name="phone"></td></tr>
      <tr><th>회원주소</th><td><input type="text" name="address" ></td></tr>
      <tr><th>가입일자</th><td><input type="text" name="joindate"> 예) 20151202</td></tr>
      <tr><th>고객등급[A:VIP, B:일반, C:직원]</th><td>
        <select name="grade">
          <option value="">선택</option>
          <option value="A">[A]VIP</option>
          <option value="B">[B]일반</option>
          <option value="C">[C]직원</option>
        </select></td></tr>
      <tr><th>도시코드</th><td><input type="text" name="city"></td></tr>
      <tr><td colspan="2" class="btn-area">
        <input type="button" value="등 록"  onclick="checkForm()">
        <input type="button" value="조 회" onclick="location.href='memberForm.jsp'">
      </td></tr>
    </table>
  </form>
</section>


<jsp:include page="footer.jsp" />
