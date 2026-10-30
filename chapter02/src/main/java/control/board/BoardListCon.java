package control.board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.board.BoardDAO;
import Model.board.BoardDTO;


@WebServlet("/BoardListCon.do") // 가장 먼저 실행하게 됨
public class BoardListCon extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//화면에 보여질 게시글의 개수를 지정한다.
		int pageSize=10;
		//현재 보여지고 있는 페이지의 넘버값을 읽어들임, 예)현재 [1][2][3]..., 현재 3페이지면 3을 읽어들임
		String pageNum = request.getParameter("pageNum");
		//현재 pageNum값은 null로 넘어오기때문에 null처리한다.
		if(pageNum == null) {
			pageNum="1";
		}
		//전체 게시글의 갯수
		int count = 0;
		//jsp내에서 보여질 넘버링 숫자값을 저장하는 변수지정
		int number=0;
		
		//현재 보여지고 있는 페이지 문자를 숫자로 형변화
		int currentPage = Integer.parseInt(pageNum);
		//전체 게시글의 개수를 가져와야 하기에 데이터베이스 객체생성한다.
		BoardDAO bdao = new BoardDAO();
		count = bdao.getAllCount(); //전체 개시글 가져오는 쿼리 메소드
		
		//현재 보여질 페이지 시작번호를 설정 (MySQL LIMIT 시작 위치 공식)
		// 올바른 LIMIT 시작 번호 공식은 (현재페이지 - 1) * 페이지당게시글수 여야 합니다. 
		// (예: 1페이지는 0부터 시작, 2페이지는 10부터 시작)
		int startRow = (currentPage - 1) * pageSize;
		//int endRow = currentPage + pageSize;
		
		//10개를 기준으로 게시글을 리턴받아주는 메소드 호출
		// 가방->데이터는 가방에 담긴다., 박스 -> 가방은 다시 박스에 담긴다.
		// 박스 -> ArrayList, 가방 -> BoardDTO
		ArrayList<BoardDTO> arr = bdao.getAllBoard(startRow, pageSize);
		number = count -(currentPage -1) * pageSize;
		
		//페이징 처리하는 소스코드 변수초기화 작업 --------------------------------------
		int pageCount = 0; //전체 페이지 넘버수를 담는 변수
		int pageBlock = 3; //한 화면에 페이징 하고 싶은 개수
		int startPage = 1; //한 화면에 제일 첫번째 페이징 넘버를 담는 변수
		int endPage = 0; //한 화면에 제일 마지막 페이징 넘버를 담는 변수

		if(count > 0) {
		    // count => 18
		    // pageSize => 5
		    // 18 % 5 ==> 3(나머지) 고로 1출력
		    // 18/5 ==> 3.6
		    // 3.6+1 => 4.6
		    // 그러므로 전체 페이징 개수는 pageCount = 4 이다.
		    // 다시말해 현재 화면에 [1] [2] [3] [다음] -> [이전] [4]
		    pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		    
		    // 첫 화면에 [1] [2] [3]의 1을, 두번째 화면의 [4] [5] [6]의 4를 담는 변수
		    if(currentPage % pageBlock != 0) {
		        startPage = (currentPage / pageBlock) * pageBlock + 1;
		    }else {
		        startPage = ((currentPage / pageBlock )-1) * pageBlock + 1;
		    }
		    
		    // 첫 화면에 [1] [2] [3]의 3을, 두번째 화면의 [4] [5] [6]의 6을 담는변수
		    endPage = startPage + pageBlock - 1;
		    
		    // 아래 조건을 작성하지 않으면 [다음] [4] [5] [6]까지 페이징 번호가 출력된다.
		    // 그러나, [5] [6]페이지는 게시글이 존재하지 않기때문에 출력되지 않도록 조건을 지정하는 부분이다.
		    if(endPage > pageCount) {
		        endPage = pageCount;
		    }
		}
		
        /////////////////////////////////////////////////수정, 삭제시 비밀번호가 틀리다면
		String msg = (String) request.getAttribute("msg");
		
		//BoardList.jsp View페이지로 request객체를 담아서 넘겨줌
		request.setAttribute("all", arr);
		request.setAttribute("number", number);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("count", count);
		request.setAttribute("currentPage", currentPage);
		
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("pageBlock", pageBlock);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp?section=board/BoardList.jsp");
		rd.forward(request, response);
	}
}
