package control.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.board.BoardDAO;


@WebServlet("/BoardUpdateProcCon.do")
public class BoardUpdateProcCon extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

        // 폼에서 넘어온 데이터를 받아옴
        int num = Integer.parseInt(request.getParameter("num"));
        String userPw = request.getParameter("userPw");
        String dbPw = request.getParameter("dbPw");
        String subject = request.getParameter("subject");
        String content = request.getParameter("content");

        // userPw와 dbPw값을 비교
        if(userPw.equals(dbPw)) { // 패스워드가 같다면 데이터 수정
            
            BoardDAO bdao = new BoardDAO();
            bdao.updateBoard(num, subject, content);
            
            // 수정이 완료되었다는 전체게시글 보기로 이동 시킴
            request.setAttribute("msg", "3");
            RequestDispatcher rdis = request.getRequestDispatcher("BoardListCon.do");
            rdis.forward(request, response);

        } else { 
            // 비밀번호가 틀리다면 이전페이지로 이동 시킴
            request.setAttribute("msg", "1");
            RequestDispatcher rdis = request.getRequestDispatcher("BoardListCon.do");
            rdis.forward(request, response);
        }
    }
	

}
