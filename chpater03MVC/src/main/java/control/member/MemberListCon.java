package control.member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.member.MemberDAO;
import model.member.MemberDTO;


@WebServlet("/MemberListCon.do")
public class MemberListCon extends HttpServlet {
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  // 데이터베이스에 연결하여 전체회원의 모든 정보를 리턴해준다.
	  // 회원 여러명의 자료를 화면에 출력하기위해 DB에서 select 꺼내온다.
	  // ArrayList<>이용하여 select로 추출한 모든 회원의 정보를 담는다.
	  MemberDAO mdao = new MemberDAO();
	  ArrayList<MemberDTO> all ;
	  
	  String keyword= request.getParameter("keyword");
	  String searchType= request.getParameter("searchType");
	  
	  if(keyword != null && searchType != null) {
		  all = mdao.searchMember(keyword, searchType);
	  }else {
		  all = mdao.getAllMember();
	  }
	  
	  // request.setAttribute()객체에 담아 디스패쳐할예정임
	  request.setAttribute("alist", all);
	  request.setAttribute("keyword", keyword);
	  request.setAttribute("searchType", searchType);
	  
	  // jsp파일로 디스패처하기
	  RequestDispatcher rd = request.getRequestDispatcher("/index.jsp?section=member/MemberList.jsp");
	  rd.forward(request, response);
	}
	

}
