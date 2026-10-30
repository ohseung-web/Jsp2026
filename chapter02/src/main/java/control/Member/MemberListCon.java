package control.Member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Member.MemberDAO;
import Model.Member.MemberDTO;


@WebServlet("/MemberListCon.do")
public class MemberListCon extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		 * //데이터 베이스에 연결하여 회원의 모든 정보를 리턴 MemberDAO mdao = new MemberDAO();
		 * ArrayList<MemberDTO> aAll = mdao.getAllMember();
		 * 
		 * //JSP로 데이터를 떠넘겨주어야 한다. request.setAttribute("m", aAll); // aAll을 JSP로 넘겨줌
		 * 
		 * RequestDispatcher rd =
		 * request.getRequestDispatcher("/index.jsp?section=member/MemberList.jsp");
		 * rd.forward(request, response);
		 */
		
		// 1. 관리자 확인 (메뉴를 숨기는 것만으로는 주소창 직접 접근을 막을 수 없다.)
		HttpSession session = request.getSession(false);
		String loginId = (session == null) ? null : (String) session.getAttribute("id");

		if (!"admin".equals(loginId)) {
			response.sendRedirect("index.jsp"); // 관리자가 아니면 메인으로
			return;
		}

		// 2. 검색 조건 받기
		String searchType = request.getParameter("searchType"); // id 또는 email
		String keyword = request.getParameter("keyword");       // 검색어

		MemberDAO mdao = new MemberDAO();
		ArrayList<MemberDTO> aAll;

		// 3. 검색어가 없으면 전체 조회, 있으면 검색
		if (keyword == null || keyword.trim().isEmpty()) {
			keyword = "";
			aAll = mdao.getAllMember();
		} else {
			keyword = keyword.trim(); // 앞뒤 공백 제거
			aAll = mdao.searchMember(searchType, keyword);
		}

		// 4. JSP 로 전달 (검색 후에도 입력한 검색어/조건이 화면에 유지되도록 함께 전달)
		request.setAttribute("m", aAll);
		request.setAttribute("searchType", searchType);
		request.setAttribute("keyword", keyword);

		RequestDispatcher rd = request.getRequestDispatcher("/index.jsp?section=member/MemberList.jsp");
		rd.forward(request, response);
	}
		
	

}
