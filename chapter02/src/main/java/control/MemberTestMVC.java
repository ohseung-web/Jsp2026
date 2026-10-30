package control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.MemberTestDTO;


@WebServlet("/MemberTestProc.do")
public class MemberTestMVC extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		MemberTestDTO mt = new MemberTestDTO();
		mt.setId(request.getParameter("id"));
		mt.setPass(request.getParameter("pass"));
		mt.setEmail(request.getParameter("email"));
		mt.setTel(request.getParameter("tel"));
		mt.setAddress(request.getParameter("address"));
		
		//request.setAttribute()°´Ã¼¿¡ MemerTestDTO°´Ã¼¸¦ ´ã´Â´Ù.
		request.setAttribute("mt", mt);
		
		RequestDispatcher rd = request.getRequestDispatcher("MemberTestView.jsp");
		rd.forward(request, response);
	}
}

