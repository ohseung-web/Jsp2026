<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="DBPKG.Util" %>

<%
    int nextNo=0;
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
 	try{
         con = Util.getConnection(); 		 
 		 
 		 // sql문을 작성하여 sql문자 변수에 담는다. sql은 혼자선 아무것도 못함
 		 // 등록할때 회원번호자동으로 1씩 증가되어 생성 : 100006
 		 // ifnull(값, 값이 null일때 출력할 값)
 		 String sql ="select ifnull(max(custno),100000)+1 as cust  from member_tbl_02";
 		 pstmt = con.prepareStatement(sql);
 		 rs = pstmt.executeQuery(); // 실행한 결과 rs에 담김
 		 
 		 // rs가 존재하는 값보다 커서 위에 존재한다.
 		 if(rs.next()){
 			 nextNo = rs.getInt("cust");
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


<jsp:include page="header.jsp" />
<section>
  <h2>홈쇼핑 회원등록</h2>
  <form action="joinProc.jsp" method="post" name="jform">
    <table class="form">
      <tr>
      	<th>회원번호(자동생성)</th>
      	<td><input type="text" name="custno" value="<%=nextNo %>" readonly></td>
      </tr>
      <tr>
      	<th>회원성명</th>
      	<td><input type="text" name="custname"></td>
      </tr>
      <tr>
      	<th>회원전화</th>
      	<td><input type="text" name="phone"></td>
      </tr>
      <tr>
      	<th>회원주소</th>
      	<td><input type="text" name="address"></td>
      </tr>
      <tr>
      	<th>가입일자</th>
      	<td><input type="text" name="joindate">예)20151202</td>
      </tr>
      <tr>
      	<th>고객등급[A:VIP,B:일반,C:직원]</th>
      	<td>
	      <select name="grade">
	        <option value="">선택</option>
	        <option value="A">[A]VIP</option>
	        <option value="B">[B]일반</option>
	        <option value="C">[C]직원</option>
	      </select>
	    </td>  
      </tr>
      <tr>
      	<th>도시코드</th>
      	<td><input type="text" name="city"></td>
      </tr>
      <tr>
      	<td colspan="2" class="btn-area">
      		<input type="button" value="등 록" onclick="checkForm()">
      		<input type="button" value="조 회" onclick="location.href='memberForm.jsp'">
      	</td>
      </tr>
    </table>
  </form>
</section>
<script type="text/javascript">
  function checkForm(){
	  let f = document.jform;
	  
	  if(f.custname.value == ""){
		  alert("회원성명 입력안됨");
		  // 커서를 회원성명으로 이동해라
		   f.custname.focus();
		  return;
	  }
	  if(f.phone.value == ""){
		  alert("전화 입력안됨");
		  // 커서를 회원성명으로 이동해라
		   f.phone.focus();
		  return;
	  }
	  if(f.address.value == ""){
		  alert("주소 입력안됨");
		  // 커서를 회원성명으로 이동해라
		   f.address.focus();
		  return;
	  }
	  if(f.joindate.value == ""){
		  alert("등록일자 입력안됨");
		  // 커서를 회원성명으로 이동해라
		   f.joindate.focus();
		  return;
	  }
	  if(f.grade.value == ""){
		  alert("등급 입력안됨");
		  // 커서를 회원성명으로 이동해라
		   f.grade.focus();
		  return;
	  }
	  if(f.city.value == ""){
		  alert("도시 입력안됨");
		  // 커서를 회원성명으로 이동해라
		   f.city.focus();
		  return;
	  }
	  
	  // submit
	  f.submit();
  }
</script>

<jsp:include page="footer.jsp" />
