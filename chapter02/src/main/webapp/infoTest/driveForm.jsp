<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/main.css">
</head>
<body>
	<h3>주행내역등록</h3>
		<form name="driveFrm" method="post" action="driveProc02.jsp" >
		    <table class="form">
		        <tr>
		            <th>주행일자</th>
		            <td>
		                <input type="text" name="drvDate" maxlength="8">
		                <span class="hint">2023년01월01일 예)20230101</span>
		            </td>
		        </tr>
		        <tr>
		            <th>차량번호</th>
		            <td>
		                <input type="text" name="carNo" maxlength="10">
		                <span class="hint">예)10가0001</span>
		            </td>
		        </tr>
		        <tr>
		            <th>출발Km</th>
		            <td>
		                <input type="text" name="drvStart"> km
		            </td>
		        </tr>
		        <tr>
		            <th>도착km</th>
		            <td>
		                <input type="text" name="drvEnd"> km
		            </td>
		        </tr>
		        <tr>
		            <th>부서코드</th>
		            <td>
		                <select name="deptCode">
		                    <option value="">부서</option>
		                    <option value="10">[10]영업부</option>
		                    <option value="20">[20]총무부</option>
		                    <option value="30">[30]구매부</option>
		                    <option value="40">[40]개발부</option>
		                </select>
		            </td>
		        </tr>
		        <tr>
		            <th>주유금액</th>
		            <td>
		                <input type="text" name="drvMoney"> 원
		            </td>
		        </tr>
		        <tr>
		            <td colspan="2" class="btn">
		                <input type="button" value="주행내역등록" onclick="chkform()" >
		                <input type="button" value="다시쓰기" onclick="resetform()">
		            </td>
		        </tr>
		    </table>
		</form>
		<!-- 자바스크립트를 이용해서 유효성검사 하기  -->
		<script type="text/javascript">
			function  chkform(){
				let f = document.driveFrm;
				if(f.drvDate.value == ""){
					alert("주행일자입력 안됨");
					/* 주행입력에 포커스(커서 이동)하는 방법  */
					f.drvDate.focus();
					return;
				}
				if(f.carNo.value == ""){
					alert("차량번호입력 안됨");
					/* 주행입력에 포커스(커서 이동)하는 방법  */
					f.carNo.focus();
					return;
				}
				if(f.drvStart.value == ""){
					alert("출발km입력 안됨");
					/* 주행입력에 포커스(커서 이동)하는 방법  */
					f.drvStart.focus();
					return;
				}
				if(f.drvEnd.value == ""){
					alert("도착km입력 안됨");
					/* 주행입력에 포커스(커서 이동)하는 방법  */
					f.drvEnd.focus();
					return;
				}
				if(f.deptCode.value == ""){
					alert("부서코드입력 안됨");
					/* 주행입력에 포커스(커서 이동)하는 방법  */
					f.deptCode.focus();
					return;
				}
				if(f.drvMoney.value == ""){
					alert("주유금액입력 안됨");
					/* 주행입력에 포커스(커서 이동)하는 방법  */
					f.drvMoney.focus();
					return;
				}
				
				/* 아직 submit이 되지 않았다. */
				f.submit();
			}
			
			function resetform(){
				let f = document.driveFrm;
				alert("정보를 지우고 다시 입력");
				f.reset();
				f.drvDate.focus();
			}
		</script>
		
		
		
		
		
		
		
		
		
		
		
		
		
</body>
</html>