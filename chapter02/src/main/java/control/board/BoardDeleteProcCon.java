package control.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.board.BoardDAO;


@WebServlet("/BoardDeleteProcCon.do")
public class BoardDeleteProcCon extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 사용자로 부터 넘어온 데이터 3개만 받는다.
		int num = Integer.parseInt(request.getParameter("num"));
		String userPw = request.getParameter("userPw");
		String dbPw = request.getParameter("dbPw");

		if(userPw.equals(dbPw)) {

		    BoardDAO bdao = new BoardDAO();
		    bdao.deleteBoard(num);
		    RequestDispatcher rdis = request.getRequestDispatcher("BoardListCon.do");
		    rdis.forward(request, response);

		} else {

		    request.setAttribute("msg", "2");
		    RequestDispatcher rdis = request.getRequestDispatcher("BoardListCon.do");
		    rdis.forward(request, response);
		}
	}

}
