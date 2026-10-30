package control.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.board.BoardDAO;
import Model.board.BoardDTO;


@WebServlet("/BoardDeleteCon.do")
public class BoardDeleteCon extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 글 삭제이기에 글번호를 입력 받는다.
		int num = Integer.parseInt(request.getParameter("num"));

		// 데이터 베이스에 접근하여 하나의 게시글을 호출하는 메서드
		BoardDAO bdao = new BoardDAO();
		BoardDTO bdto = bdao.getOneUpdateBoard(num); // BoardDAO에 이미 작성한 getOneUpdateBoard() 메서드를 이용한다.

		request.setAttribute("bdto", bdto);
		RequestDispatcher rdis = request.getRequestDispatcher("index.jsp?section=board/BoardDeleteForm.jsp");
		rdis.forward(request, response);
	}

}
