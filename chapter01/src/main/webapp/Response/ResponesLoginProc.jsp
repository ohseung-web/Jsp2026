<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <h2> 로그인 처리 페이지 </h2>
 <%
    request.setCharacterEncoding("utf-8");
    // db에 id, pw가 존재한다고 설정
    String dbid ="aaaa";
    String dbpw = "1234";
    
    // request 객체를 이용해서 id, pw의 입력정보를 꺼내온다.
    String id = request.getParameter("id");
    String pass = request.getParameter("pass");
    
    // dbid, dbpw의 데이터와 입력받은, id, pass가 같으면 main화면으로 이동
    if(dbid.equals(id) && dbpw.equals(pass)){
    	/* ResponseMain.jsp로 이동 */
    	/* Response 내장 객체를 이용하여 서버에서 사용자의 응답정보를 가지고 있는 객체이다.
    	   sendRedirect()메소드를 이용하여 다른페이지로 이동한다.
    	*/
    	/* get방식을 이용하여 ResponseMain.jsp로 id떠넘기기 */
    	// http://localhost:8080/chapter01/Response/ResponseMain.jsp?id=aaaa
    	response.sendRedirect("ResponseMain.jsp?id="+id);
    }else{
    
 %>
   <script type="text/javascript">
     alert("아이디와 비밀번호를 확인하세요");
     history.go(-1);
   </script>
 <% } %>
 
   
 <!--  화면 출력 -->
 <p>아이디:<%= id %></p>
 <p>비밀번호:<%= pass %></p>
</body>
</html>