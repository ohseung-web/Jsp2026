<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="java.sql.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
</head>
<body>
	<%
			request.setCharacterEncoding("utf-8");
			String id = request.getParameter("id");
			String email = request.getParameter("email");
			String tel = request.getParameter("tel");
			String pass2 = request.getParameter("pass2");
		
			String msg = null;
			
		    Connection con = null;
			PreparedStatement pstmt = null;
			
			// DB접속 정보 설정
			String driver = "com.mysql.cj.jdbc.Driver"; //JDBC드라이버
			// DB URL(스키마 이름 : jspdb)
			String url ="jdbc:mysql://localhost:3306/jspdb?serverTimezone=UTC&useSSL=false";
			String user ="root"; //DB계정 아이디
			String password = "1234";//DB계정 비밀번호
			
			// select문 담는 ResultSet객체 변수 생성
			ResultSet rs = null;
			// 비밀번호 체크키
			boolean passChk = false;
			
			// 비밀번호의 일치유무를 판단한다.
			if(pass2 == null || pass2.trim().isEmpty()){
				msg="비밀번호를 입력하세요";
			}else{
				
				try{
					System.out.println("2번, 요기까지 왔니?");
					// 드라이브 연결
					Class.forName(driver);
					// DB연동
					con = DriverManager.getConnection(url, user, password);
					
					// 1)비밀번호 확인 
					String sql ="select id from member where id=? and pass=?";
					pstmt = con.prepareStatement(sql);
					// sql문의 ?에 대응하는 부분
					pstmt.setString(1,id);
					pstmt.setString(2,pass2);
					// select문은 ResultSet()객체에 담아라
					rs = pstmt.executeQuery();
					
					// 현재 rs는 id정보가 같은 한 사람의 정보만 가진다.
					if(rs.next()){
						//자원반납 위의 조회때 사용한 pstmt를 반납해야한다.
						pstmt.close();
						rs.close();
						
					   // 2)비밀번호 확인이 종료되면 수정하기
					   // update 테이블명 set 수식(a=b) where 조건 
					   String sql2 = "update member set email=?, tel=? where id=?";
					   pstmt = con.prepareStatement(sql2);
					   pstmt.setString(1, email);
					   pstmt.setString(2, tel);
					   pstmt.setString(3, id);
					   
					   // update, insert, delete쿼리문은 결과값으로 int를 반환받는다.
					   // update가 실행되면 1이된다. 실행되지 않으면 0이된다.
					   
					   int result = pstmt.executeUpdate();
					   if(result > 0){
						   msg="업데이트 성공";
						   passChk = true;
					   }else{
						   msg="업데이트 실패";
					   }
					   
					}else{
						msg="비밀번호를 확인하세요";
						/* 회원정보 수정하는 스크립트 작성해야 함 */
					}
		             			
				}catch(Exception e){
					e.printStackTrace();
					System.out.println("3번, 요기까지 왔니?");
				}finally{
					if(rs != null){
						try{
					          rs.close();		
						}catch(Exception e){
							e.printStackTrace();
						}
					}
					if(con != null){
						try{
							con.close();
						}catch(Exception e){
							e.printStackTrace();
						}
					}
					if(pstmt != null){
						try{ 
					    	pstmt.close();	
						}catch(Exception e){
							e.printStackTrace();
						}
					}
				}
				
			}
	%>
	
	<script type="text/javascript">
		alert("<%=msg %>");
		
	   <% if(passChk){%>
		location.href="main.jsp?page=MemberList";		   
	   <%}else{%>
		  history.go(-1);
	   <%}%>
		//history.go(-2);
	</script>
</body>
</html>