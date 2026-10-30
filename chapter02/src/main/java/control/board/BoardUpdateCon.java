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

@WebServlet("/BoardUpdateCon.do")
public class BoardUpdateCon extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void reqPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 해당 번호를 읽어 들인다.
		int num = Integer.parseInt(request.getParameter("num"));

		// 데이터 베이스에서 하나의 게시글에 대한 정보를 리턴메소드 호출
		BoardDAO bdao = new BoardDAO();
		BoardDTO bdto = bdao.getOneUpdateBoard(num); // BoardDAO에 getOneUpdateBoard() 메서드를 작성한다.

		request.setAttribute("bdto", bdto);

		// sendRedirect는 request 영역을 공유하지 않으므로,
		// BoardUpdateForm.jsp나 별도의 수정 진입 컨트롤러로 num 값을 파라미터로 넘겨주어야 합니다.
		// response.sendRedirect("index.jsp?section=board/BoardUpdateForm.jsp?num=" +
		// num);

		
		 RequestDispatcher rdis =
		 request.getRequestDispatcher("index.jsp?section=board/BoardUpdateForm.jsp");
		 rdis.forward(request, response);
		
	}

}
