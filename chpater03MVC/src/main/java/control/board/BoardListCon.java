package control.board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.board.BoardDAO;
import model.board.BoardDTO;


@WebServlet("/BoardListCon.do") //header.jsp의 게시판메뉴 클릭하면 목록이 출력되도록 작성
public class BoardListCon extends HttpServlet {
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// header.jsp로 넘어갈때 페이징할 변수를 담아서 떠넘겨주어야 함
		// 아래 부분은 페이징을 하기위한 기본 변수와 연산식을 작성할 예정임
		// board테이블의 모든 레코드가 넘겨저야 함
		// DAO가 필요함 => getAllboard(startRow, pageSize) 메소드
		
		// 전체 게시글 리턴하여 담을 변수 설절
		int count = 0;
		// 한 화면에 보여질 행의 개수를 담을 변수
		// 한 화면에 5개씩만 보여주기로 함
		int pageSize =5;
		// 현재 보고있는 페이지 넘버 [1][2][3] ==> 현재 1페이지에 있음
		// pageNum = 1;
		// 현재 pageNum = null이다.
		// 반드시 null처리한다.
		String pageNum=request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum ="1";
		}
		// 게시글의 번호를 최신글순으로 출력되도록 번호를 지정하기위해
		// 각자 기호에 맞추어 개발한다.
		int number=0;
		// 현재 보여지고 있는 페이지 문자를 숫자로 변환
		// 현재 currentPage=1이됨
		int currentPage = Integer.parseInt(pageNum);
		
		// 전체 게시글의 개수를 데이터 베이스에서 가져오기위해 BoardDAO를 인스턴스한다.
		BoardDAO bdao = new BoardDAO();
		count = bdao.getAllCount(); //현재 count=10;
		
		// startRow를 계산해야 시작하는 행번호를 [1][2][3]처럼 보고있는 페이지의
		// 시작행으로 출력할 수 있다.
		// limit 시작위치, 개수
		// currentPage=1, 한페이지의 출력할 개수는 pageSize=5;
		// [1] => 첫 번째행은 0 ~ 4
		// [2] => 첫 번째행은 5 ~ 9
		// [3] => 첫 번째행은 10 ~ 14
		int startRow = (currentPage-1)*pageSize;
		
		//최신글 5개를 가져오는 DAO메소드를 이용해 리턴
		// ArrayList<BoardDTO>
		ArrayList<BoardDTO> blist = bdao.getAllboard(startRow, pageSize);
		
		// jsp 화면에 [번호]부분에 들어갈 number 값을 계산하는 부분
		// 단, 최신글 순서대로 번호가 출력된다.
		// count=9, currentPage=1, 
		// => 현재 보고있는 [1]페이지 첫 번째 글 번호가 10이어야한다.
		// => 현재 보고있는 [1]페이지 마지막 글 번호가 6이어야한다.
		// 9   4  
		// 5   3
		// [1] [2]
		// [1] 9 8 7 6 5 , [2] 4 3 2 1
	
		//number = count-(currentPage -1)*pageSize;
		number = count-startRow;// 9-0=9, 9-5=4
		//----------------------------------------
		// 페이징 처리한 계산로직
		int pageCount=0; //전체 페이지 넘버수를 담는 변수
		int pageBlock=3; //한 화면에 페이징하고 싶은 개수 예)[1][2][3]
		int startPage=1; //한 화면에 제일 첫번째 페이징 넘버를 담는 변수 예)[1]
		int endPage=0;//한 화면에 제일 마지막 페이징 넘버를 담는 변수 예)[3]
		
		if(count>0) {
			
			//           10 / 5 => 2 + 0
			// 지금 레코드개수 10개 => [1][2]
			// 지금 현재 11개 => [1][2][3]
			pageCount = count/pageSize + (count % pageSize == 0 ? 0:1);
			
			//    1      %     3 = 0
			if(currentPage % pageBlock != 0) {
				//                (1/3)=>0*3=>0+1
				// [1][2][3] ▶, [4][5][6] ▶, [7][8][9]
				startPage = (currentPage / pageBlock)*pageBlock+1;
			}else {              
				//             3/3=1=>1*3+1=>4
				//             4
				startPage = ((currentPage / pageBlock)-1)*pageBlock+1;				
			}
			
			// [1][2][3] => 현재 보고있는 페이지가 [3]
			//  3 % 3 = 0   ==> else ((3/3)=>1*3 => 3+1)==>4
			// 현재 보고있는 페이지의 첫번째 번호가 pageBlock의 개수유지될때까지 계속 [1]
			
			// 첫 화면에 [1][2][3]의 3을, [4][5][6]의 6을 담는 변수
			endPage = startPage + pageBlock -1;
			
			//페이징의 번호가 [1][2][3]이 출력되는 경우는 count의 데이터값이 10개 이상일 경우이어야함
			// count가 10개이면 페이징번호는 [1][2]만 존재해야함
			if(endPage > pageCount) {
				endPage = pageCount;
			}
			
		}
		
		//-----------------------------------
		//HttpSession session = request.getSession(false); //없으면 null나옴
		//String loginId=(String)session.getAttribute("id");
		
		// BoardList.jsp View단으로 Dispatcher이용하여 떠넘기기
		request.setAttribute("blist", blist); //페이징한 5개의 행이 담겨있다.
		
		// 페이징을 그림그릴 변수 넘기기
		request.setAttribute("number", number);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("count", count);
		request.setAttribute("currentPage", currentPage);
		
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("pageBlock", pageBlock);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		//request.setAttribute("id",loginId );
		
		RequestDispatcher rd = request.getRequestDispatcher("/index.jsp?section=board/BoardList.jsp");
		rd.forward(request, response);
	}
}








