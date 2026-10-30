package control.Member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Member.MemberDAO;
import Model.Member.MemberDTO;


@WebServlet("/MemProc.do")
public class MemberJoinProc extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 파라미터로 넘어온데이터를 MembdrDTO에 저장함
		request.setCharacterEncoding("utf-8");
		MemberDTO mdto = new MemberDTO();
		MemberDAO mdao = new MemberDAO();
		
		String pass = request.getParameter("pass");
		String passchk = request.getParameter("passchk");
		String id = request.getParameter("id");
		
		String chkId = mdao.getId(id);
		System.out.println("입력 id=[" + id + "], 조회 결과 chkId=[" + chkId + "]");
		
		
		mdto.setId(id);
		mdto.setPass(pass);
		mdto.setPasschk(passchk);
		mdto.setEmail(request.getParameter("email"));
		mdto.setTel(request.getParameter("tel"));
		
		// hobby는 동시에 여러개 선택이 가능해야 하므로 배열로 받아온다.
		String[] arr = request.getParameterValues("hobby");
		String oneHobby = "";
		for(String hob : arr) {
			oneHobby += hob+" ";//하나의 스트림으로 데이터 연결
		}
		mdto.setHobby(oneHobby);
		
		mdto.setJob(request.getParameter("job"));
		mdto.setAge(request.getParameter("age"));
		mdto.setInfo(request.getParameter("info"));
		
		//패스워드가 같을 경우에만 데이터 베이스에 저장
		if(id.equals(chkId)) {
			request.setAttribute("msg", "이미 존재하는 아이디 입니다.");
			RequestDispatcher rd = request.getRequestDispatcher("/member/joinIdError.jsp");
			rd.forward(request, response);	
			
		}else if(pass.equals(passchk)) {
			//데이터 베이스 객체 생성함
			mdao.insertMember(mdto);
			
			//컨트롤러에서 또다른 컨트롤러를 호출해주어야 함.
			//control -> member -> MemberListcon 서블릿을 생성한다.
//			RequestDispatcher rd = request.getRequestDispatcher("/MemberListCon.do");
//			rd.forward(request, response);
			

			// ★ 성공 : forward → sendRedirect 로 변경 (PRG 패턴)
			// 브라우저가 MemberListCon.do 를 새로 GET 요청하므로
			// 새로고침(F5) 해도 회원가입이 다시 실행되지 않는다.
			response.sendRedirect("MemberListCon.do");

			
		}else {
			request.setAttribute("msg", "패스워드가 일치하지 않습니다.");
			RequestDispatcher rd = request.getRequestDispatcher("/member/joinError.jsp");
			rd.forward(request, response);
		}
		
	}

}
