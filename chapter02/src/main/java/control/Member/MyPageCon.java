package control.Member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Member.MemberDAO;
import Model.Member.MemberDTO;

/*
 * 메뉴의 [MyPage] 를 클릭하면 실행되는 서블릿
 * 역할 : 로그인한 회원 본인의 정보를 DB 에서 조회하여 MyPage.jsp 화면으로 전달한다.
 */

// 이 서블릿을 "MyPage.do" 주소로 호출할 수 있게 등록 (header.jsp 의 MyPage 링크 주소와 같아야 함)
@WebServlet("/MyPage.do")
public class MyPageCon extends HttpServlet {

	// GET 방식 요청 : 메뉴 링크(<a href="MyPage.do">) 클릭 또는 주소창 입력
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response); // GET 이든 POST 든 같은 처리를 하도록 reqPro 로 모은다.
	}

	// POST 방식 요청 : 폼 전송 등으로 들어온 경우
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	// 실제 조회 처리를 하는 메소드
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 1. 로그인 확인 (세션에 id 가 없으면 로그인 화면으로)
		// getSession(false) : 세션이 있으면 가져오고, 없으면 새로 만들지 않고 null 을 리턴
		HttpSession session = request.getSession(false);

		// 세션이 없으면 null, 있으면 로그인할 때 저장해 둔 "id" 값을 꺼낸다. (Object 타입이라 String 으로 형변환)
		String loginId = (session == null) ? null : (String) session.getAttribute("id");

		// 로그인하지 않은 사용자는 MyPage 를 볼 수 없으므로 로그인 화면으로 보내고 처리를 끝낸다.
		if (loginId == null) {
			response.sendRedirect("index.jsp?section=login/loginForm.jsp");
			return; // 아래 코드가 실행되지 않도록 메소드 종료
		}

		// 2. 파라미터가 아닌 "세션의 id" 로 본인 정보를 조회 (다른 사람 정보 조회 방지)
		// 주소창으로 id 를 넘겨받아 조회하면 다른 사람 id 로 바꿔서 볼 수 있기 때문에,
		// 로그인할 때 서버가 저장해 둔 세션의 id 를 사용한다.
		MemberDAO mdao = new MemberDAO();                // DB 작업을 담당하는 DAO 객체 생성
		MemberDTO mdto = mdao.getOneMember(loginId);     // select 쿼리로 회원 한 명의 정보를 가져온다.

		// 조회한 회원정보를 request 에 "mdto" 라는 이름으로 저장
		// → MyPage.jsp 에서 ${mdto.email}, ${mdto.tel} 처럼 꺼내 쓸 수 있다.
		request.setAttribute("mdto", mdto);

		// 3. 화면으로 이동 : index.jsp 가 section 파라미터에 지정된 MyPage.jsp 를 include 하여 보여준다.
		// forward 는 같은 request 를 그대로 넘기므로, 위에서 저장한 mdto 가 JSP 에서 유지된다.
		// (redirect 를 쓰면 request 가 새로 만들어져서 mdto 가 사라진다.)
		RequestDispatcher rd = request.getRequestDispatcher("/index.jsp?section=member/MyPage.jsp");
		rd.forward(request, response);
	}
}