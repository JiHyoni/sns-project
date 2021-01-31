package mysns.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import mysns.util.*;

public class MemberDAO {
	
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	Logger logger = LoggerFactory.getLogger(MemberDAO.class);
	
	public boolean addMember(Member member) { //추가) 생년월일
		conn = DBManager.getConnection();
		String sql = "insert into s_member(name, uid, passwd, email, year,date) values(?,?,?,?,?,now())";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getName());
			pstmt.setString(2, member.getUid());
			pstmt.setString(3, member.getPasswd());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getYear());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}",e.getErrorCode());
			return false;
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}
	
	public boolean login(String uid, String passwd) {
		conn = DBManager.getConnection();
		String sql = "select uid, passwd from s_member where uid = ?";
		boolean result = false;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();
			rs.next();
			if(rs.getString("passwd").equals(passwd))
				result=true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public ArrayList<String> getNewMembers() {
		ArrayList<String> nmembers = new ArrayList<String>();
		conn = DBManager.getConnection();
		String sql = "select * from s_member order by date desc limit 0,7";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				nmembers.add(rs.getString("uid"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}",e.getErrorCode());
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return nmembers;
	}
	public boolean searchMember(String uid) { // 추가한 내용) 친구 추가 기능: 존재하는 아이디인지 검색해본다. 
		conn = DBManager.getConnection();
		String sql = "select uid from s_member where uid=?"; //s_member 테이블에서 uid 만 가져와서 검색 
		boolean result1 = false;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();
			rs.next();
			if(rs.getString("uid").equals(uid))
				result1=true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result1;
	}

	public boolean addFriend(String uid) { //추가한 내용) 친구 추가 기능: 추가할 친구들을 테이블에 넣는다. 
		conn = DBManager.getConnection();
		String sql = "insert into s_friend(uid) values(?)"; 
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}",e.getErrorCode());
			return false;
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}
	
	public ArrayList<String> getNewFriends() { // 추가한 내용 ) 친구 추가 기능: 친구 목록 불러오기 
		ArrayList<String> nfriends = new ArrayList<String>();
		conn = DBManager.getConnection();
		
		String sql = "select * from s_friend";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				nfriends.add(rs.getString("uid"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}",e.getErrorCode());
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return nfriends;
	}

	public ArrayList<Member> getManage() { // 추가한 내용 ) 관리자 창에 회원 목록 불러오기 
		ArrayList<Member> manage = new ArrayList<Member>();
		conn = DBManager.getConnection();
		String sql = "select uid, name, email, year from s_member";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Member member = new Member();
				member.setUid(rs.getString("uid"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setYear(rs.getString("year")); 
				manage.add(member);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}",e.getErrorCode());
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return manage;
	}
	public boolean delMember(String uid) { // 추가한 내용 ) 회원 탈퇴 기능 
		conn = DBManager.getConnection();
		String sql = "delete from s_member where uid=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}",e.getErrorCode());
			return false;
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}
	
}
