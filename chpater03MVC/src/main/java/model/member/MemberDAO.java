package model.member;

import java.sql.*;
import java.util.ArrayList;

import DBPKG.Util;

public class MemberDAO {
	// 멤버변수
	Connection con=null;
	PreparedStatement pstmt = null;
	ResultSet rs=null;
	
	//---- 아래부분은 sql문작성 메소드들의 모임이다.
	// id만 추출하는 메소드를 작성한다.
	// 메소드이름 : getId()
	public String getId(String id) {
		String chkid ="";
		
		try {
			//DB연결
			con = Util.getConnection();
			//sql문작성 준비
			String sql ="select id from member where id=?";
			// 실행할 쿼리 객체 선언
			pstmt = con.prepareStatement(sql);
			// ?에 대입
			pstmt.setString(1, id);
			
			// 쿼리실행
			rs = pstmt.executeQuery();
			// 현재 커서는 앞에 존재하므로 next()로 다음 데이터를 찾아간다.
			if(rs.next()) {
				chkid = rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
				
			}catch(Exception e) {e.printStackTrace();}
		}
		
		return chkid;
	}
	
	//------------------------------------------------
	// 한사람의 데이터만 DB에 저장하는 메소드 작성
	public void insertMember(MemberDTO mdto) {
		
		try {
			 con = Util.getConnection();
			 String sql ="insert into member values(?,?,?,?,?,?,?,?)";
			 pstmt = con.prepareStatement(sql);
			 
			 // ? 대입
			 pstmt.setString(1, mdto.getId());
			 pstmt.setString(2, mdto.getPass());
			 pstmt.setString(3, mdto.getEmail());
			 pstmt.setString(4, mdto.getTel());
			 pstmt.setString(5, mdto.getHobby());
			 pstmt.setString(6, mdto.getJob());
			 pstmt.setString(7, mdto.getAge());
			 pstmt.setString(8, mdto.getInfo());
			 
			 // 쿼리실행
			 pstmt.executeUpdate();
			 
			 
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e) {e.printStackTrace();}
		}
	}
	
	// ---------------------------------------------
	// 회원의 전체의 정보를 추출하는 메소드 생성
	public ArrayList<MemberDTO> getAllMember(){
		
		//리턴 타입문을 선언한다.
		ArrayList<MemberDTO> m = new ArrayList<MemberDTO>();
		
		try {
			 con = Util.getConnection();
			 String sql ="select * from member";
			 pstmt = con.prepareStatement(sql);
			 // 쿼리실행
			 rs = pstmt.executeQuery();
             			 
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
				 
				 // ArrayList에 추가하기
				 m.add(mdto);
			 }
			 
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e) {e.printStackTrace();}
		}
		
		
		return m;
	}
	
	//---- 2026년 10월 28일 DB 쿼리 업데이트
	// 메소드이름 : loginCheck(),
	// id, pass select 쿼리문작성
	
	public boolean loginCheck(String id, String pass) {
		//리턴할 변수명 지정
		boolean logChk = false; //현재 로그아웃 상태
		
		try {
			
			con = Util.getConnection();
			// sql문
			String sql ="select id from member where id=? and pass=?";
			pstmt = con.prepareStatement(sql);
			// ? 대입
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			// sql 실행
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				logChk = true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e) {e.printStackTrace();}
		}
		
		// 리턴
		return logChk;
	}
	
	//---------------------------------------
	// 이메일 또는 아이디로 회원목록 검색하는 메소드 작성
	
	public ArrayList<MemberDTO> searchMember(String keyword, String searchType){
		   
		    ArrayList<MemberDTO> m = new ArrayList<MemberDTO>();
		    
		    try {
				
				con = Util.getConnection();
				String filed = "email".equals(searchType)? "email":"id";
				
				String sql ="select * from member where "+ filed + " like '%"+keyword+"%'";
				pstmt = con.prepareStatement(sql);
				// 쿼리실행
				 rs = pstmt.executeQuery();
	             			 
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
					 
					 // ArrayList에 추가하기
					 m.add(mdto);
				 }
				 
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if(rs != null) rs.close();
					if(pstmt != null) pstmt.close();
					if(con != null) con.close();
				}catch(Exception e) {e.printStackTrace();}
			}
			
			// 리턴
		    return m;
		
	}
	
	
	
	
	
	
	
	
	
	
			
}
