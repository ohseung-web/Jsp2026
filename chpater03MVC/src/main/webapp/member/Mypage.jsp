<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
    
 <c:if test="${param.result == 'ok' }">
   <script>alert("회원정보 수정됨")</script>
 </c:if>   
 
 <c:if test="${param.result == 'passfail' }">
   <script>alert("비밀번호 확인 요망")</script>
 </c:if>   
 
<div class="joinwrap">
 	<h2 align="center"> MyPage </h2>
 	<form action="MyPageUpdate.do" method="post" name="mfrm">
 		<table width="500" border="1">
 			<tr height="50">
 				<td align="center" width="150">아이디</td>
 				<td width="350">
 				    <input type="hidden" value="${mdto.id }" name="id" />
 					<input type="text" name="id" value="${mdto.id }" readonly>
 				</td>
 			</tr>
 			<tr height="50">
 				<td align="center" width="150">비밀번호</td>
 				<td width="350">
 					<input type="password" name="pass" placeholder="영문과 숫자만 입력하세요">
 				</td>
 			</tr>
 			<tr height="50">
 				<td align="center" width="150">비밀번호 확인</td>
 				<td width="350">
 					<input type="password" name="passchk" placeholder="영문과 숫자만 입력하세요">
 				</td>
 			</tr>
 			<tr height="50">
 				<td align="center" width="150">Email</td>
 				<td width="350">
 					<input type="email" name="email" value="${mdto.email }" placeholder="@를 포함하여 입력하세요">
 				</td>
 			</tr>
 			<tr height="50">
 				<td align="center" width="150">전화번호</td>
 				<td width="350">
 					<input type="tel" name="tel" value="${mdto.tel }" placeholder="010-0000-0000 형식으로 입력하세요">
 				</td>
 			</tr>
 			<tr height="50">
 				<td align="center" width="150">관심분야</td>
 				<td width="350">
 					<c:forTokens items="캠핑 등산 영화 독서" delims=" " var="item">
 						<input type="checkbox" name="hobby" value="${item }" id="hobby_${item}" 
 						 <c:if test="${mdto.hobby.contains(item) }">checked</c:if> />
 						<label for="hobby_${item}">${item}</label>&nbsp;&nbsp; 
 					</c:forTokens>
 				</td>
 			</tr>
 			<tr height="50">
 				<td width="150" align="center">직업</td>
 				<td width="350" align="center">
 					<select name="job">
 						<option value="교사" ${mdto.job=='교사'?'selected':'' }>교사</option>
 						<option value="변호사" ${mdto.job=='변호사'?'selected':'' }>변호사</option>
 						<option value="의사" ${mdto.job=='의사'?'selected':'' }>의사</option>
 						<option value="기술사" ${mdto.job=='기술사'?'selected':'' }>기술사</option>
 					</select>
 				</td>
 			</tr>
 			<tr height="50">
 				<td align="center" width="150">연령</td>
 				<td width="350">
 					<input type="radio" name="age" value="10대" id="teenage" ${mdto.age=='10대'?'checked':'' }>
 					<label for="teenage">10대</label>&nbsp;&nbsp;
 					<input type="radio" name="age" value="20대" id="twenty" ${mdto.age=='20대'?'checked':'' }>
 					<label for="twenty">20대</label>&nbsp;&nbsp;
 					<input type="radio" name="age" value="30대" id="thirty" ${mdto.age=='30대'?'checked':'' }>
 					<label for="thirty">30대</label>&nbsp;&nbsp;
 					<input type="radio" name="age" value="40대" id="forty" ${mdto.age=='40대'?'checked':'' }>
 					<label for="forty">40대</label>&nbsp;&nbsp;
 				</td>
 			</tr>
 			<tr height="50">
 				<td align="center" width="150">남기는 말</td>
 				<td width="350">
 					<textarea rows="5" cols="40" name="info">${mdto.info}</textarea>
 				</td>
 			</tr>	
 			<tr height="50">
 				<td colspan="2" align="center">
					<input type="button" value="수정" onclick="checkform()"> 					
					<input type="reset" value="취소"> 					
 				</td>
 			</tr>	
 		</table>
 	</form>
 </div>
 
 <script type="text/javascript">
    function checkform(){
    	let f = document.mfrm;
    	
      	
    	let hobCheck =false;
    	for(let i=0; i<f.hobby.length; i++){
    		if(f.hobby[i].checked){
    			hobCheck = true;
    			break;
    		}
    	}
    	
    	if(!hobCheck){
    		alert("관심분야를 선택하세요");
    		f.hobby[0].checked='checked';
    		return;
    	}  
    	
    	f.submit();
    }
 </script>
 