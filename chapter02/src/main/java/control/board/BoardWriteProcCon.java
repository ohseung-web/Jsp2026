
package control.board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.board.BoardDAO;
import Model.board.BoardDTO;

@WebServlet("/BoardWriteProcCon.do")
public class BoardWriteProcCon extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession(false);
		String loginId = (String) session.getAttribute("id");

		// 로그인하지 않은 경우: 알림창을 띄우고 로그인 페이지로 이동
				if (loginId == null) {
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('로그인이 필요합니다.');");
					out.println("location.href='index.jsp?section=login/loginForm.jsp';");
					out.println("</script>");
					out.close();
					return;
				}
				
		        // BoardDTO 데이터 읽어들인다.
		        BoardDTO bdto = new BoardDTO();
		        bdto.setWriter(request.getParameter("writer"));
		        bdto.setSubject(request.getParameter("subject"));
		        bdto.setEmail(request.getParameter("email"));
		        bdto.setPassword(request.getParameter("password"));
		        bdto.setContent(request.getParameter("content"));
		        
		        // ★ [핵심 수정] 로그인한 회원의 ID를 DTO에 반드시 세팅해주어야 합니다!
		        bdto.setId(loginId);
		        
		        // BoardDAO 객체 생성 및 저장 메소드 호출
		        BoardDAO bdao = new BoardDAO();
		        bdao.insrtBoard(bdto);
		        
		        response.sendRedirect("BoardListCon.do");
				/*
				 * RequestDispatcher rdis = request.getRequestDispatcher("BoardListCon.do");
				 * rdis.forward(request, response);
				 */
			}
	}


