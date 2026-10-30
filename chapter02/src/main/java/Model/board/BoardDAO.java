package Model.board;

import java.sql.*;
import java.util.ArrayList;

import DBPKG.Util;
import Model.Member.MemberDTO;

public class BoardDAO {
    
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	//회원 한사람에 대한 정보를 저장하는 메소드를 만든다.
		public int getAllCount() {
	
			//게시글 전체수를 저장하는 변수
			int count =0;

			try {
				con = Util.getConnection();
				//쿼리준비
				String sql="select count(*) from board ";
				//쿼리를 실행할 객체 선언
				pstmt = con.prepareStatement(sql);
				//쿼리 실행후 결과를 리턴
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					count = rs.getInt(1);//전체게시글수
				}
				 
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if(rs !=null) rs.close();
					if(pstmt !=null) pstmt.close();
					if(con !=null) con.close();
				}catch(Exception e) {e.printStackTrace();}
			}
			
			return count;
		}
		
		//--------------------------------------------------
		// 화면에 보여질 데이터를 10개씩 추출해서 리턴하는 메소드
		public ArrayList<BoardDTO> getAllBoard(int startRow, int pageSize) {
			
			ArrayList<BoardDTO> a = new ArrayList<BoardDTO>();

			try {
				con = Util.getConnection();
				//쿼리준비
				// 쿼리준비: limit [시작위치], [가져올개수]
				String sql="select * from board order by ref desc, re_step asc limit ?, ? ";
				//쿼리를 실행할 객체 선언
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, pageSize);
				//쿼리 실행후 결과를 리턴
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					BoardDTO bdto = new BoardDTO();
					bdto.setNum(rs.getInt(1));
					bdto.setWriter(rs.getString(2));
					bdto.setEmail(rs.getString(3));
					bdto.setSubject(rs.getString(4));
					bdto.setPassword(rs.getString(5));
					bdto.setReg_date(rs.getString(6));
					bdto.setRef(rs.getInt(7));
					bdto.setRe_step(rs.getInt(8));
					bdto.setReadcount(rs.getInt(9));
					bdto.setContent(rs.getString(10));
					bdto.setId(rs.getString(11));
					
					//패키징한 데이터를 ArrayList에 저장
					a.add(bdto);
				}
				 
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if(rs !=null) rs.close();
					if(pstmt !=null) pstmt.close();
					if(con !=null) con.close();
				}catch(Exception e) {e.printStackTrace();}
			}
			
			return a;
		}
		
		//---------------------------------------------------------
		// 하나의 게시글 호출 및 저장하는 메소드
		public void insrtBoard(BoardDTO bdto) {

		    int ref = 0;
		    int re_step = 1; // 새글
		    try {
		    	con = Util.getConnection();
		        String refsql = "select max(ref) from board";
		        pstmt = con.prepareStatement(refsql);
		        rs = pstmt.executeQuery();
		        if(rs.next()) {
		            ref = rs.getInt(1)+1; // 가장 큰 값에 1을 더한다.
		        }
		        // 데이터를 삽입하는 쿼리
		        String sql = "insert into board values(null,?,?,?,?,current_date(),?,?,0,?,?)";
		        pstmt = con.prepareStatement(sql);
		        pstmt.setString(1, bdto.getWriter());
		        pstmt.setString(2, bdto.getEmail());
		        pstmt.setString(3, bdto.getSubject());
		        pstmt.setString(4, bdto.getPassword());
		        pstmt.setInt(5, ref);
		        pstmt.setInt(6, re_step);
		        pstmt.setString(7, bdto.getContent());
		        pstmt.setString(8, bdto.getId());
		        pstmt.executeUpdate();

		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
				try {
					if(rs !=null) rs.close();
					if(pstmt !=null) pstmt.close();
					if(con !=null) con.close();
				}catch(Exception e) {e.printStackTrace();}
			}
		}
		
		//-------------------------------------------
		// 하나의 답글을 저장하는 메소드
		public void reinsertBoard(BoardDTO bdto) {
		    // 원글의 ref, re_step값을 가져옴
		    int ref = bdto.getRef();
		    int re_step = bdto.getRe_step();

		    try {
		        con = Util.getConnection();
		        
		        // 1. 답글 정렬을 위한 핵심 로직 (부모글보다 re_step이 큰 값이 있다면 1씩 증가시킴)
		        String levelsql = "update board set re_step = re_step + 1 where ref = ? and re_step > ?";
		        pstmt = con.prepareStatement(levelsql);
		        pstmt.setInt(1, ref);
		        pstmt.setInt(2, re_step);
		        pstmt.executeUpdate();
		        
		        // 2. 답글의 re_step과 re_level을 1씩 증가시킴
		        re_step = re_step + 1;
		        
		        // 3. 답글 데이터를 삽입하는 쿼리
		        String sql = "insert into board values(null,?,?,?,?,current_date(),?,?,0,?,?)";
		        pstmt = con.prepareStatement(sql);
		        pstmt.setString(1, bdto.getWriter());
		        pstmt.setString(2, bdto.getEmail());
		        pstmt.setString(3, bdto.getSubject());
		        pstmt.setString(4, bdto.getPassword());
		        pstmt.setInt(5, ref);       // 부모와 같은 그룹(ref)
		        pstmt.setInt(6, re_step);   // 1 증가된 re_step
		        pstmt.setString(7, bdto.getContent());
		        pstmt.setString(8, bdto.getId());
		        pstmt.executeUpdate();

		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        try {
		            if(rs != null) rs.close();
		            if(pstmt != null) pstmt.close();
		            if(con != null) con.close();
		        } catch(Exception e) {
		            e.printStackTrace();
		        }
		    }
		}
		
		
		//-------------------------------------------
		// 하나의 게시글을 리턴받는 메소드 작성
		public BoardDTO getOneBoard(int num) {
			
		    BoardDTO bdto = new BoardDTO();
		    try {
		    	con = Util.getConnection();
		        // 게시글을 클릭하는 순간 조회수 증가
		        String countsql ="update board set readcount = readcount + 1 where num=?";
		        pstmt = con.prepareStatement(countsql);
		        pstmt.setInt(1, num);
		        pstmt.executeUpdate();

		        // 한 게시글에 대한 정보를 리턴해주는 쿼리를 작성
		        String sql = "select * from board where num=? ";
		        pstmt = con.prepareStatement(sql);
		        pstmt.setInt(1, num);
		        rs = pstmt.executeQuery();
		        if(rs.next()) {
		            bdto.setNum(rs.getInt(1));
		            bdto.setWriter(rs.getString(2));
		            bdto.setEmail(rs.getString(3));
		            bdto.setSubject(rs.getString(4));
		            bdto.setPassword(rs.getString(5));
		            bdto.setReg_date(rs.getDate(6).toString());
		            bdto.setRef(rs.getInt(7));
		            bdto.setRe_step(rs.getInt(8));
		            bdto.setReadcount(rs.getInt(9));
		            bdto.setContent(rs.getString(10));
		            bdto.setId(rs.getString(11));
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        try {
		            if(rs != null) rs.close();
		            if(pstmt != null) pstmt.close();
		            if(con != null) con.close();
		        } catch(Exception e) {
		            e.printStackTrace();
		        }
		    }
		    return bdto;
		}
		
		
		//------------------------------------------------------
		// 하나의 게시글 정보를 수정 폼 출력을 위해 리턴받는 메소드 (조회수 증가 없음)
		public BoardDTO getOneUpdateBoard(int num) {
		    BoardDTO bdto = new BoardDTO();
		    try {
		    	con = Util.getConnection();
		        String sql = "select * from board where num=?";
		        pstmt = con.prepareStatement(sql);
		        pstmt.setInt(1, num);
		        rs = pstmt.executeQuery();
		        if(rs.next()) {
		            bdto.setNum(rs.getInt(1));
		            bdto.setWriter(rs.getString(2));
		            bdto.setEmail(rs.getString(3));
		            bdto.setSubject(rs.getString(4));
		            bdto.setPassword(rs.getString(5));
		            bdto.setReg_date(rs.getDate(6).toString());
		            bdto.setRef(rs.getInt(7));
		            bdto.setRe_step(rs.getInt(8));
		            bdto.setReadcount(rs.getInt(9));
		            bdto.setContent(rs.getString(10));
		            bdto.setId(rs.getString(11));
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        try {
		            if(rs != null) rs.close();
		            if(pstmt != null) pstmt.close();
		            if(con != null) con.close();
		        } catch(Exception e) {
		            e.printStackTrace();
		        }
		    }
		    return bdto;
		}
		
		//--------------------------
		// 업데이트 쿼리
		// 게시글 번호에 해당하는 제목과 내용을 수정하는 메소드
		public void updateBoard(int num, String subject, String content) {
		    try {
		        con = Util.getConnection();
		        
		        // 쿼리 준비 (subject와 content를 수정)
		        String sql = "update board set subject=?, content=? where num=?";
		        pstmt = con.prepareStatement(sql);
		        pstmt.setString(1, subject);
		        pstmt.setString(2, content);
		        pstmt.setInt(3, num);
		        
		        // 쿼리 실행
		        pstmt.executeUpdate();

		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        try {
		            if(pstmt != null) pstmt.close();
		            if(con != null) con.close();
		        } catch(Exception e) {
		            e.printStackTrace();
		        }
		    }
		}
		
		//--------------------
		// 게시글 번호에 해당하는 데이터를 삭제하는 메소드
		public void deleteBoard(int num) {
		    try {
		        con = Util.getConnection();
		        
		        // 쿼리 준비 (num에 해당하는 게시글 삭제)
		        String sql = "delete from board where num=?";
		        pstmt = con.prepareStatement(sql);
		        pstmt.setInt(1, num);
		        
		        // 쿼리 실행
		        pstmt.executeUpdate();

		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        try {
		            if(pstmt != null) pstmt.close();
		            if(con != null) con.close();
		        } catch(Exception e) {
		            e.printStackTrace();
		        }
		    }
		}
		
		
		
		
}
