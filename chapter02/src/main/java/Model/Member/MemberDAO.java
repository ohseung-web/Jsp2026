package Model.Member;

import java.sql.*;
import java.util.ArrayList;

import DBPKG.Util;

public class MemberDAO {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	//회원 한사람에 대한 정보를 저장하는 메소드를 만든다.
	public void insertMember(MemberDTO mdto) {
		
		try {
			 con = Util.getConnection();
			 //쿼리준비
			 String sql ="insert into member values(?,?,?,?,?,?,?,?)";
			 //쿼리실행할 객체 선언
			 pstmt = con.prepareStatement(sql);
			 //?에 대입
			 pstmt.setString(1, mdto.getId());
			 pstmt.setString(2, mdto.getPass());
			 pstmt.setString(3, mdto.getEmail());
			 pstmt.setString(4, mdto.getTel());
			 pstmt.setString(5, mdto.getHobby());
			 pstmt.setString(6, mdto.getJob());
			 pstmt.setString(7, mdto.getAge());
			 pstmt.setString(8, mdto.getInfo());
			 
			 //쿼리실행
			 pstmt.executeUpdate();
			 
			 
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs !=null) rs.close();
				if(pstmt !=null) pstmt.close();
				if(con !=null) con.close();
			}catch(Exception e) {e.printStackTrace();}
		}
	}
	
	//------------------------------------------------
	//모든 회원의 정보를 리턴하는 메소드 작성
	public ArrayList<MemberDTO> getAllMember(){
		
		// 리턴타입 선언한다.
		ArrayList<MemberDTO> m = new ArrayList<MemberDTO>();
		
		try {
			 con = Util.getConnection();
			 //쿼리준비
			 String sql ="select * from member";
			 //쿼리실행할 객체 선언
			 pstmt = con.prepareStatement(sql);
			 
			 //쿼리실행
			 rs = pstmt.executeQuery();
             //반복문을 돌려서 회원정보를 저장한다.
			 while(rs.next()) {
				 MemberDTO mdto = new MemberDTO();
				 mdto.setId(rs.getString(1));
				 mdto.setPass(rs.getString(2));
				 mdto.setEmail(rs.getString(3));
				 mdto.setTel(rs.getString(4));
				 mdto.setHobby(rs.getString(5));
				 mdto.setJob(rs.getString(6));
				 mdto.setAge(rs.getString(7));
				 mdto.setInfo(rs.getString(8));
				 //ArrayList에 MemberDTO를 저장한다.
				 m.add(mdto);
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
		return m;
	}
	
	
	//------ 한사람의 id만 select 하여 가져오기
	public String getId(String id) {
		
		String chkId = null;
		
		try {
			 con = Util.getConnection();
			 //쿼리준비
			 String sql ="select id from member where id=?";
			 //쿼리실행할 객체 선언
			 pstmt = con.prepareStatement(sql);
			 pstmt.setString(1,id);
			 
			 //쿼리실행
			 rs = pstmt.executeQuery();
            //반복문을 돌려서 회원정보를 저장한다.
			 if(rs.next()) {
				 chkId = rs.getString(1);
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
		
		return chkId;
	}
	
	// ----------------------------------------
	// 한사람의 id, password를 select하는 메소드
	// 아이디/비밀번호가 일치하는 회원이 있으면 true, 없으면 false 리턴
		public boolean loginCheck(String id, String pass) {

			boolean result = false;

			try {
				con = Util.getConnection();
				String sql = "select id from member where id=? and pass=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, pass);

				rs = pstmt.executeQuery();
				if (rs.next()) {
					result = true;
					System.out.println(rs.getString(1));
					
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null) rs.close();
					if (pstmt != null) pstmt.close();
					if (con != null) con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			return result;
		}
	
		//-------------------------------------------------------------------------
	    // 한사람의 정보를 리턴하는 메소드(Mypage 용)
		public MemberDTO getOneMember(String id) {

			MemberDTO mdto = null;

			try {
				con = Util.getConnection();
				String sql = "select * from member where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);

				rs = pstmt.executeQuery();
				if (rs.next()) {
					mdto = new MemberDTO();
					mdto.setId(rs.getString(1));
					mdto.setPass(rs.getString(2));
					mdto.setEmail(rs.getString(3));
					mdto.setTel(rs.getString(4));
					mdto.setHobby(rs.getString(5));
					mdto.setJob(rs.getString(6));
					mdto.setAge(rs.getString(7));
					mdto.setInfo(rs.getString(8));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null) rs.close();
					if (pstmt != null) pstmt.close();
					if (con != null) con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			return mdto;
		}

		//----------------------------------------------------
		// 한사람의 회원정보 수정하는 메소드
		// 회원 정보 수정 (id 는 where 조건으로만 사용, 변경 불가)
		public void updateMember(MemberDTO mdto) {

			try {
				con = Util.getConnection();
				String sql = "update member set pass=?, email=?, tel=?, hobby=?, job=?, age=?, info=? where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mdto.getPass());
				pstmt.setString(2, mdto.getEmail());
				pstmt.setString(3, mdto.getTel());
				pstmt.setString(4, mdto.getHobby());
				pstmt.setString(5, mdto.getJob());
				pstmt.setString(6, mdto.getAge());
				pstmt.setString(7, mdto.getInfo());
				pstmt.setString(8, mdto.getId());

				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null) rs.close();
					if (pstmt != null) pstmt.close();
					if (con != null) con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		//-----------------------------------------------------------
		// 관리자인 경우 회원정보 검색하는 메소드
		// 아이디 또는 이메일로 회원 검색 (일부만 입력해도 검색되는 "포함 검색")
		// type : "id" 또는 "email",  keyword : 검색어
		public ArrayList<MemberDTO> searchMember(String type, String keyword) {

			ArrayList<MemberDTO> m = new ArrayList<MemberDTO>();

			try {
				con = Util.getConnection();

				// 컬럼명은 ?(PreparedStatement)로 넣을 수 없으므로 직접 문자열에 붙여야 한다.
				// 사용자가 보낸 값을 그대로 붙이면 SQL 인젝션 위험이 있으므로,
				// 허용한 값(id / email)만 골라서 사용한다.
				String column = "email".equals(type) ? "email" : "id";

				String sql = "select * from member where " + column + " like ? order by id";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%"); // 앞뒤에 % → 검색어가 포함된 모든 값

				rs = pstmt.executeQuery();
				while (rs.next()) {
					MemberDTO mdto = new MemberDTO();
					mdto.setId(rs.getString(1));
					mdto.setPass(rs.getString(2));
					mdto.setEmail(rs.getString(3));
					mdto.setTel(rs.getString(4));
					mdto.setHobby(rs.getString(5));
					mdto.setJob(rs.getString(6));
					mdto.setAge(rs.getString(7));
					mdto.setInfo(rs.getString(8));
					m.add(mdto);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null) rs.close();
					if (pstmt != null) pstmt.close();
					if (con != null) con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			return m;
		}

		
}
