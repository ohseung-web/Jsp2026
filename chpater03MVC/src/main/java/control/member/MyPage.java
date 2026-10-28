package control.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/MyPage.do")
public class MyPage extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  // 힌트 HttpSession 객체를 이용하여 세션이 null이면 로그인이 안된상태
	  // 세션이 null이 아니면 로그인된상태로 null이 아닐때 id값을 session.getAttribute("id")로 받아온다.
		
	}

	
	
	
	
	
	
	
	
	
}
