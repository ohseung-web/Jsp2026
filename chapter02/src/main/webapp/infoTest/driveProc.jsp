<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import ="java.util.*"%>
<%@ page import="java.sql.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	   request.setCharacterEncoding("utf-8");
	
	   String drvDate = request.getParameter("drvDate");
	   String carNo = request.getParameter("carNo");
	   
	   //String drvStart = request.getParameter("drvStart");
	   int drvStart = Integer.parseInt(request.getParameter("drvStart"));
	   
	   String drvEnd = request.getParameter("drvEnd");
	   String deptCode = request.getParameter("deptCode");
	   String drvMoney = request.getParameter("drvMoney");
	   
	   String msg = null;
	   if(drvDate == null || drvDate.trim().isEmpty()){
		   msg="주일일자 입력 안됨";
	   }else if(carNo == null || carNo.trim().isEmpty()){
		   msg="차량번호 입력 안됨";
	   }else if(drvStart == 0 ){
		   msg="출발km 입력 안됨";
	   }else if(drvEnd == null || drvEnd.trim().isEmpty()){
		   msg="도착km 입력 안됨";
	   }else if(deptCode == null || deptCode.trim().isEmpty()){
		   msg="부서코드 입력 안됨";
	   }else if(drvMoney == null || drvMoney.trim().isEmpty()){
		   msg="주유금액 입력 안됨";   
	   }
	   
	   if(msg != null){
	%>
	<script type="text/javascript">
	   alert(<%= msg %>);
	   history.go(-1);
	</script>
	<%
	   }else {
		   
		    Connection con = null;
		    PreparedStatement pstmt = null;
		    
		    // select문 담는 ResultSet객체 변수 생성
		    ResultSet rs = null;
		    
		    // DB접속 정보 설정
		    String driver = "com.mysql.cj.jdbc.Driver"; //JDBC드라이버
			// DB URL(스키마 이름 : jspdb)
			String url ="jdbc:mysql://localhost:3306/jspdb?serverTimezone=UTC&useSSL=false";
		    String user ="root"; //DB계정 아이디
		    String password = "1234";//DB계정 비밀번호
		    
		 try{
			 
			//DB 연결  => 드라이버 로드
			   Class.forName(driver);
	           // DB연결
	           con = DriverManager.getConnection(url, user, password);
	           
	           String sql = "insert into TBL_DRIVE values(?,?,?,?,?,?)";
	           pstmt = con.prepareStatement(sql);
	           
	           // pstmt 객체에 입력받은 값을 저장하여 sql의 insert문이 실행되도록한다.
	           pstmt.setString(1,drvDate);
	           pstmt.setString(2,carNo);
	           pstmt.setInt(3, drvStart);
	           pstmt.setInt(4,Integer.parseInt(drvEnd));
	           pstmt.setString(5,deptCode);
	           pstmt.setInt(6, Integer.parseInt(drvMoney));
	          
	           // 실행
	           pstmt.executeUpdate();
	    %>
	        <script type="text/javascript">
	          alert("주문내역 정상 등록됨");
	          location.href = "index.jsp";
	        </script>       
	   <%    
		 }catch(Exception e){
			   e.printStackTrace();
		%>	   
			    <script type="text/javascript">
	             alert("등록 실팽");
	             history.go(-1);
	           </script> 
	     <%      
		   }finally{
			   if(rs != null){
				   try{
					   rs.close();
				   }catch(Exception e){}
			   }
			   if(con != null){
				   try{
					   con.close();
				   }catch(Exception e){}
			   }
			   if(pstmt != null){
				   try{
					   pstmt.close();
				   }catch(Exception e){}
			   }
		   }
		 
	   }
	
	%>
</body>
</html>