<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/main.css">
</head>
<body>
	 <%
	 	request.setCharacterEncoding("utf-8");
	    // 지금현재 pageName = null이다.
	    // pageName은 반드시 null처리한다.		
	    String pageName = request.getParameter("page");
	    String content = null;
	    
		 if("carList".equals(pageName)){
		    	content = "carList.jsp";
		 }else if("driveForm".equals(pageName)){			 
		    	content = "driveForm.jsp";
		 }else if("driveList".equals(pageName)){			 
		    	content = "driveList.jsp";
		 }else if("deptStat".equals(pageName)){			 
		    	content = "deptStat.jsp";
		 }
		 
		// pageName = "index.jsp"; 
	   
		/* if(pageName.equals("carList") && pageName != null){
	    	content = "carList.jsp";
	    }else if(pageName.equals("dirveForm") && pageName != null){
	    	content = "dirveForm.jsp";
	    }else if(pageName.equals("dirveList") && pageName != null){
	    	content = "dirveList.jsp";
	    }else if(pageName.equals("deptStat") && pageName != null){
	    	content = "deptStat.jsp";
	    }  */
	    
	    
	 
	 %>
	 
	<div id="wrap">
	    <%@ include file="header.jsp" %>
	    <section>
	        <%
	           if(content != null){
	        %>
	            <jsp:include page="<%= content %>"></jsp:include>
	        <%}else { %>    
	            <h3>과정평가형 자격 CBQ</h3>
	            <p>국가직무능력표준(NCS:National Competency Standards)으로 설계된 교육·훈련과정을 충실히 이수한 후,
	               내부·외부 평가를 거쳐 일정 합격 기준을 충족하는 교육·훈련생에게 국가기술자격을 부여하는 제도</p>
	            <p class="bold">산업현장 중심의 교육평가로 더 커지는 능력!</p>
	            <p class="bold">알고 있는 것에 할 수 있는 것을 더하는</p>
	            <p class="bold">과정평가형 자격은</p>
	            <p class="bold">현장 중심형 인재육성을 지원 합니다.</p>
	        <%} %>    
	      
	    </section>
	    <%@ include file="footer.jsp" %>
	</div>
	
</body>
</html>