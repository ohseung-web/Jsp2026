package control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.MemberTestDTO;


@WebServlet("/Mproc.do") // form의 action부분을 매핑한다.
public class MemberTestPro extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
//		MemberTestDTO 가방만들었음
//      --> 사용용도:MemberTest.jsp에서 입력한 input의 name속성값
//	        MemberTestDTO 담는다.
//		단, MemberTestDTO는 클래스이므로 인스턴스화 해야 사용할 수 있다.
		
		MemberTestDTO mtdto = new MemberTestDTO();
		mtdto.setId(request.getParameter("id"));
		mtdto.setPass(request.getParameter("pass"));
		mtdto.setEmail(request.getParameter("email"));
		mtdto.setTel(request.getParameter("tel"));
		mtdto.setAddress(request.getParameter("address"));
		
		// request객체의 setAttribute("이름",값)를 통해 mtdto를 한꺼번에 담아
		// MemberTestView.jsp로 넘긴다.
		// jsp로 넘긴 상태에서 화면그릴때 mt를 표현식에 담는다.
		request.setAttribute("mt", mtdto);
		
//		MemberTestView.jsp 페이지에 내보내기 할때 사용하는 명령어
//		RequestDispatcher(요청한 내용을 내보내다) 객체이다.
//		rquest.getRequestDispatcher("내보낼 jsp파일명을 적는다.")
		RequestDispatcher rd = request.getRequestDispatcher("MemberTestView.jsp");
		rd.forward(request, response); //forward()앞으로
	
	}

}
