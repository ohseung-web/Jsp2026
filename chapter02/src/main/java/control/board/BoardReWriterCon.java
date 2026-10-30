package control.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/BoardReWriterCon.do")
public class BoardReWriterCon extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// BoardInfo에서 넘겨준 데이터 저장
        int num = Integer.parseInt(request.getParameter("num"));
        int ref = Integer.parseInt(request.getParameter("ref"));
        int re_step = Integer.parseInt(request.getParameter("re_step"));

        // view-jsp로 떠넘겨 주어야 한다.
        request.setAttribute("ref", ref);
        request.setAttribute("re_step", re_step);

        RequestDispatcher rdis = request.getRequestDispatcher("index.jsp?section=board/BoardReWriteForm.jsp");
        rdis.forward(request, response);
	
	}

}
