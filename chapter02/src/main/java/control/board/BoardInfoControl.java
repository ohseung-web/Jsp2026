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


@WebServlet("/BoardInfoControl.do")
public class BoardInfoControl extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// num값을 리턴 받는다.
        int num = Integer.parseInt(request.getParameter("num"));

        // 데이터베이스 접근
        BoardDAO bdao = new BoardDAO();
        // 하나의 게시글에 대한 정보를 리턴
        BoardDTO bdto = bdao.getOneBoard(num);

        // view-jsp 페이지로 떠넘긴다.
        request.setAttribute("bdto", bdto);
        RequestDispatcher rdis = request.getRequestDispatcher("/index.jsp?section=board/BoardInfo.jsp");
        rdis.forward(request, response);
	}

}
