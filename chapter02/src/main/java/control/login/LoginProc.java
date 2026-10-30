package control.login;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Member.MemberDAO;


@WebServlet("/loginProc.do")
public class LoginProc extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		String id = request.getParameter("id");
		String pass = request.getParameter("pass");

		MemberDAO mdao = new MemberDAO();
		boolean ok = mdao.loginCheck(id, pass);
         
		if (ok) {
			// 로그인 성공 : 세션에 아이디 저장
			HttpSession session = request.getSession();
			session.setAttribute("id", id);
			session.setMaxInactiveInterval(60 * 30); // 30분

			response.sendRedirect("index.jsp");
		} else {
			// 로그인 실패
			request.setAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			RequestDispatcher rd = request.getRequestDispatcher("/login/loginError.jsp");
			rd.forward(request, response);
		}
	}
	}

