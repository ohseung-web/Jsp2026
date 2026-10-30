package control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/HelloWorld") // /HelloWorld라고 주소 URL에 표시해주어야 이 서블릿 클래스가 실행된다.
public class HelloWorld extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   reqPro(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	// doGet, doPost이던 reqPro가 처리되도록 한다.
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 화면에 HelloWrold라고 출력
		// java클래스이르모 JSP쪽으로 넘겨질 데이터를 설정한다.
		
		String msg = "HelloWorld ~~";
		Integer data = 12;
		// jsp쪽으로 데이터를 request를 부착하여 넘겨줌
		request.setAttribute("msg", msg);
		request.setAttribute("data", data);
		
		// 서블릿에서 Jsp를 호출하면서 데이터를 같이 넘겨주는 객체를 선언
		RequestDispatcher rd = request.getRequestDispatcher("HelloWorld.jsp");
		rd.forward(request, response);
		
	}
	
	
}
