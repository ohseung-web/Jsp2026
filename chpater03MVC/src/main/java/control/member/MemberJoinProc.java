package control.member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.member.MemberDAO;
import model.member.MemberDTO;


@WebServlet("/MProc.do")
public class MemberJoinProc extends HttpServlet {
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 서블릿 작성순서
		// 1) 인코딩 하기
		// 2) input입력받은 값 request.getParametr()가져오기
		// 3) MemberDTO 인스턴스하기
		// 4) MemberDAO 인스턴스하기
		// 5) 예외처리하기 (중복아이디체크, pass=passchk..)
		// 6) request.setAttribute("이름",값)저장
		// 7) RequestDispatcher객체로 jsp파일로 forward하기

		request.setCharacterEncoding("utf-8");
		
		MemberDTO mdto = new MemberDTO();
		MemberDAO mdao = new MemberDAO();
		
		// k123
		String id = request.getParameter("id");
		mdto.setId(id);
		// DAO의 getId()메소드를 추출
		String chkid = mdao.getId(id); 
		
		String pass = request.getParameter("pass"); 
		String passchk = request.getParameter("passchk"); 
		
		// 콘솔출력
		System.out.println("입력 :["+id+"], 조회 결과 ["+ chkid+"]");
		
		// mdto가방에 input에서 받은 값을 꺼내어 담는다.
		mdto.setPass(pass);
		mdto.setPasschk(passchk);
		mdto.setEmail(request.getParameter("email"));
		mdto.setTel(request.getParameter("tel"));
		
		// hobby는 체크박스이므로 동시에 여러개가 선택되어 저장되도록 코드 작성해야 함 
		String[] arr = request.getParameterValues("hobby");
		String oneHobby = "";
		// 확장 for문이용하여 배열의 값 출력
		for(String hob:arr) {
			oneHobby += hob + " ";
		}
		mdto.setHobby(oneHobby);
		mdto.setJob(request.getParameter("job"));
		mdto.setAge(request.getParameter("age"));
		mdto.setInfo(request.getParameter("info"));
		
		// 예외처리 중복아이디 체크 => 현재 체크불가능, 이유는 현재 DB연결안되어 있음
		// pass = passchk가 같으면 member테이블에 insert해야함	
		// pass가 틀리면 비밀번호를 확인하세요 
		
		// 패스워드가 같을때만 데이터 베이스에 저장 => insert
		// 중복아이디체크
		String jspAddress ="";
		if(id.equals(chkid)) {
			request.setAttribute("msgid", "이미 존재하는 아이디 입니다.");
			jspAddress = "/member/joinIderr.jsp";
		}else if(pass.equals(passchk)) { // 패스워드 pass=passchk
			// mdao의 insert쿼리문
			mdao.insertMember(mdto);
			
			// 회원전체 목록을 출력하는 MemberList생성할 예정
			// MemberJoinProc 컨트롤러에서 -> MemberListCon.do 컨트롤러로 이동
			// jsp에서 insert/update/delete 처럼 DB가 수정되는 쿼리는 
			// --> forward가 아니라 sendRedirect로 내보내기한다.
			// jsp에서는 select 처럼 단순히 검색한 내용을 화면에 출력할때만 forward로 내보내기한다.
			// forward는 F5(새로고침)하면 원래요청을 재전송하는 특징을 가진다.
			// sendRedirect는 이동한 주소만 재요청한다.
			// sendRedirect는 response의 메소드이다.
			// response.sendRedirect()이다.
			//jspAddress ="/MemberListCon.do";
			
			//response.sendRedirect("MemberListCon.do");
			response.sendRedirect("index.jsp");
			// return을 이용하여 메소드 밖으로 빠저나간다.
			return;
   			
		}else {
			request.setAttribute("msg", "비밀번호를 확인하세요");
			jspAddress = "/member/joinerr.jsp";
		}

		RequestDispatcher rd = request.getRequestDispatcher(jspAddress);
		rd.forward(request, response);

        		
	}

}
