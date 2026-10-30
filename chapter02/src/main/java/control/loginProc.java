package control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 서블릿 매핑을 폼과 같은 경로로 바꾸기
@WebServlet("/login/loginProc.do")
public class loginProc extends HttpServlet {
		
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	public void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String pass = request.getParameter("password");
		System.out.println("id ="+id);
		System.out.println("pw ="+pass);
		
		request.setAttribute("id", id); //request객체에 데이터를 저장
		request.setAttribute("password", pass); //request객체에 데이터를 저장
		
		// RequestDispatcher 객체를 이용해 id를 loginProc.do로 떠넘겨준다
		RequestDispatcher dis = request.getRequestDispatcher("loginProc.jsp");
		dis.forward(request, response);
	}

}
