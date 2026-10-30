<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="style/boardlist.css" />

<c:if test="${msg != null }">
<script type="text/javascript">
    alert("비밀번호를 확인하세요");
</script>
</c:if>

<div class="boardwrap">
		<h2> 전체 게시글 보기 </h2>
		<table width="700" border="1" bordercolor="skyblue">
			<tr height="40" >
				<td colspan="5" align="right">
				<button onclick="location.href='index.jsp?section=board/BoardWriteForm.jsp'" >글쓰기</button>
				</td>
			</tr>
			<tr height="40">
				<td width="50" align="center"> 번호 </td>
				<td width="320" align="center"> 제목 </td>
				<td width="100" align="center"> 작성자 </td>
				<td width="150" align="center"> 작성일 </td>
				<td width="80" align="center"> 조회수 </td>
			</tr>
			<c:set var="number" value="${number }" />
			<c:forEach var="bdto" items="${all}">
			
			<tr height="40">
				<td width="50" align="center"> ${number} </td>
				<td width="320" align="left"> 
				    <c:if test="${bdto.re_step > 1 }">
						<c:forEach var="i" begin="1" end="${(bdto.re_step - 1)*5}" >
							&nbsp;
						</c:forEach>
					</c:if>
					<a href="BoardInfoControl.do?num=${bdto.num}">${bdto.subject}</a>
				</td>
				<td width="100" align="center"> ${bdto.writer} </td>
				<td width="150" align="center"> ${bdto.reg_date} </td>
				<td width="80" align="center"> ${bdto.readcount} </td>
			</tr>
			<c:set var="number" value="${number-1}"></c:set>
			</c:forEach>
		</table>
		
		<%-- 페이지 카운터링 하기 --%>
		<div class="pageing">
		    <!-- 페이지 카운터링 소스 작성 [1] [2] [3] [다음] ....... -->
		
		    <!-- [이전]이라는 링크를 만들건지 파악-->
		    <c:if test="${startPage > pageBlock }">
		        <a href="BoardListCon.do?pageNum=${startPage - pageBlock}"> [이전]
		        </a>
		    </c:if>
		
		    <!-- 페이징 처리 -->
		    <c:forEach var="i" begin="${startPage}" end="${endPage}">
		        <a href="BoardListCon.do?pageNum=${i}"> [${i}] </a>
		    </c:forEach>
		
		    <!-- [다음]이라는 페이지를 만들건지 파악 -->
		    <c:if test="${endPage < pageCount }">
		        <a href="BoardListCon.do?pageNum=${startPage + pageBlock}"> [다음]
		        </a>
		    </c:if>
		</div>
</div>