package control.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.member.MemberDAO;
import model.member.MemberDTO;


@WebServlet("/MyPageUpdate.do")
public class MyPageUpdate extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		MemberDAO mdao=new MemberDAO();
		MemberDTO mdto = new MemberDTO();
		
		// Mypage.jsp에서 input hidden의 value값을 받아옴
		String id = request.getParameter("id");
		
		String pass = request.getParameter("pass");
		String passchk = request.getParameter("passchk");
		
		// 비밀번호와 비밀번호체크가 다르면 수정을 하지 않고 오류메시지 띄울예정
		// MyPage.do 서블릿에 result=passfail지정
		if(!pass.equals(passchk)) {
		    response.sendRedirect("MyPage.do?result=passfail");
		    return;
		}
		
		String[] arr = request.getParameterValues("hobby");
		String oneHobby ="";
		
		if(arr != null) {
			for(String hob : arr) {
				oneHobby += hob + " ";
			}			
		}
		
		// 나머지 MemberDTO 가방에 담는다
		mdto.setId(id);
		mdto.setPass(pass);
		mdto.setEmail(request.getParameter("email"));
		mdto.setTel(request.getParameter("tel"));
		mdto.setHobby(oneHobby);
		mdto.setJob(request.getParameter("job"));
		mdto.setAge(request.getParameter("age"));
		mdto.setInfo(request.getParameter("info"));
		
		// DAO 업데이트 메소드 실행
		mdao.updateMember(mdto);
		
		response.sendRedirect("MyPage.do?result=ok");
		
		
	}

}
