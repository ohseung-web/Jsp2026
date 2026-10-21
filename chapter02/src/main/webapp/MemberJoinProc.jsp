<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" %>
<%@ page import="java.sql.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>
	<h1>회원 가입 하기</h1>
	<%
	    /* 스크립트릿은 자바코드만 작성 가능하다. */
	 	request.setCharacterEncoding("utf-8");
	     
	    // RequestJoin.jsp의 입력된 정보를 Request 객체를 통해
	    // 정보를 꺼내오세요

	    String id = request.getParameter("id"); // id="aaa"
	    String pass = request.getParameter("pass");
	    String passchk = request.getParameter("passchk");
	    String email = request.getParameter("email");
	    String phone = request.getParameter("tel");
	    
	    /* 체크박스는 동시에 여러개를 선택해야 하므로 배열에 담는다. */
	    String hobbyOne = ""; // 하나의 관심분야 담는 변수
	    String[] hobby = request.getParameterValues("hobby");
	    for(int i=0; i<hobby.length;i++){
	    	hobbyOne += hobby[i]+" ";
	    }
	    
	    String job = request.getParameter("job");
	    String age = request.getParameter("age");
	    String info = request.getParameter("info");
	    
	    // DB 연동 시작 -------------------------------------
	    
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    
	    // select문 담는 ResultSet객체 변수 생성
	    ResultSet rs = null;
	    // id를 체크하는 체크키
	    boolean idChk = false;
	    
	    // DB접속 정보 설정
	    String driver = "com.mysql.cj.jdbc.Driver"; //JDBC드라이버
		// DB URL(스키마 이름 : jspdb)
		String url ="jdbc:mysql://localhost:3306/jspdb?serverTimezone=UTC&useSSL=false";
	    String user ="root"; //DB계정 아이디
	    String password = "1234";//DB계정 비밀번호
	  
	    /* DB는 네트워크의 톰캣서버를 통해 데이터가 전달되므로 개발자가
	       오류를 찾기 어렵다. 고로 try{}catch(){}문을 이용해 작성함이 원칙이다.
	    */
	    
	    try{
	    	
	    	// 드라이버 로딩
	    	Class.forName(driver);
	    	// DB연결
	        con = DriverManager.getConnection(url, user, password);
	    	// insert 쿼리문작성
	    	
	    	// 기존에 회원 id가 존재하면 "이미 존재하는  아이디 입니다." 창띄우기
	    	//---------------------------------------------------
	    	// select문 이용 
	    	   String chkSql="select id from member where id=?";
	    	   pstmt = con.prepareStatement(chkSql); // kjb1045
	    	   pstmt.setString(1, id);
	    	   // select문은 실할때 반드시 ResultSet객체에 담는다.
	    	   rs = pstmt.executeQuery();
			// 현재 rs로 받온 값이 존재하는지 유무 if로 비교
			if(rs.next()){
				// rs.next()가 true이면 이미같은 id가 존재한다라는 의미임
				idChk = true;
			}else{
	    	String sql = "insert into member values(?,?,?,?,?,?,?,?)";
	    	pstmt = con.prepareStatement(sql);
	    	
	    	// preparaStatement객체에 setString(), setInt()..메소드가 존재
	    	// set~()메소드는 sql문을 저장하겠다는 의미이다.
	    	// pstmt.setString(1, id) => 첫번째 필드는 id이다.
	    	// 단, 반드시 1부터 시작한다.
	    	pstmt.setString(1, id); //id="aaa"
	    	pstmt.setString(2, pass);
	    	pstmt.setString(3, email);
	    	pstmt.setString(4, phone);
	    	pstmt.setString(5, hobbyOne);
	    	pstmt.setString(6, job);
	    	pstmt.setString(7, age);
	    	pstmt.setString(8, info);
	    	
	    	// inset는 executeUpdate()메소드를 이용하여 실행함
	    	// insert, delete, updete쿼리는 executeUpdate()메소드를 이용하여 실행한다.
	    	// select => exexuteQuery()메소드를 이용하여 실행함
	    	//           단, select의 결과는 ResultSet객체에 담는다.
	    	pstmt.executeUpdate(); // insert를 성공하면 1을 반환
		   }	
	    }catch(Exception e){
	    	e.printStackTrace();
	    }finally{
	    	// 자원해제는 반드시 작성할 것
	    	if(pstmt != null){
	    		try{
	    			pstmt.close();
	    		}catch(Exception e){}
	    	}
	    	if(con != null){
	    		try{
	    			con.close();
	    		}catch(Exception e){}
	    	}
	    	if(rs != null){
	    		try{
	    			rs.close();
	    		}catch(Exception e){}
	    	}
	      	
	    }
	     
	    // DB 연동 종료 --------------------------------------
	    
	    
	    String msg = "";
	    /* 비밀번호와 비밀번호체크가 같아야 회원가입 성공
	       비밀번호와 비밀번호체크가 다르면 비밀번호가 틀립니다. 메시지 창 띄우기
	       
	       텍스트 입력창은 비워두고 제출하면 null이아니고 ""(빈 문자열)러 넘어오고,
	       체크박스, 라디오 버튼은 선택하지 않으면 null로 넘어온다.
	    */
	    if(id == null || id.isEmpty()){
	    	msg ="아이디를 입력하세요";
	    }else if(pass == null || pass.isEmpty()){
	    	msg ="비밀번호를 입력하세요";
	    }else if(passchk == null || passchk.isEmpty()){
	    	msg ="비밀번호 확인을 입력하세요";
	    }else if(!pass.equals(passchk)){
	    	msg ="비밀번호가 틀립니다.";
	    }else if(email == null || email.isEmpty()){
	    	msg ="이메일을 입력하세요";
	    }else if(phone == null || phone.isEmpty()){
	    	msg ="전화번호를 입력하세요";
	    }else if(hobby == null || hobby.length == 0){
	    	msg ="관심분야를 한개 이상 입력하세요";
	    }else if(job == null || job.isEmpty()){
	    	msg ="직업을 선택하세요";
	    }else if(age == null){
	    	msg = "연령을 선택하세요";
	    }else if(idChk){
	        msg ="이미 존재하는 아이디 입니다.";	
	    } 
	    
	    // msg 예외처리 할 것
	    if(msg != ""){
	%>
	<!-- 
	     자바스크립트 객체 종류
	     1. 코어객체
	     2. DOM객체
	     3. BOM객체 ==> 브라우저에서 사용하는 객체
	     
	        history객체는 브라우저가 현재 탭이나 창에서 방문했던 웹페이지들의
	        기록(Session History)을 관리하고 제어하는 객체이다.
	        
	        * history 객체의 메소드 종류
	          - history.back() : 바로 이전 페이지로 이동(뒤로가기)
	          - history.forward() : 바로 다음 페이지로 이동(앞으로 가기)
	          - history.go(n) : 지정한 상대적 위치만큼 이동
	            - history.go(1)은 앞으로 가기
	            - history.go(0)은 현재페이지
	            - history.go(-1)은 뒤로 가기
	 -->
	<script type="text/javascript">
		alert("<%= msg %>");
		history.go(-1);
	</script>
	
    <%}  %>
	
</body>
</html>