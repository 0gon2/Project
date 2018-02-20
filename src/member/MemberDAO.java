package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;



public class MemberDAO {
	// 싱글턴 메소드(1)
	private static MemberDAO instance = new MemberDAO();

	private MemberDAO() {

	}

	public static MemberDAO getInstance() {
		return instance;
	}
	//커넥션 연결 메소드(1)
	public static Connection getConnection() {
		Connection con = null;
		try {
			String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:orcl";
			String dbId = "scott";
			String dbPass = "tiger";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		} catch (Exception e) {
			e.printStackTrace();

		}
		return con;
	}

	// 커넥션 해제 메소드(1)
	public void close(Connection con, PreparedStatement pstmt, ResultSet rs) {
		if (rs != null)
			try {
				pstmt.close();
			} catch (SQLException ex) {

			}
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException ex) {

			}
		if (con != null)
			try {
				con.close();
			} catch (SQLException ex) {

			}

	}
	
	public void insertMember(MemberVO member) {
		Connection con = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int number = 0;
		try {
			sql = "insert into member(memberid, password,name,birthday,sch_emt,sch_mid,sch_high,";
			sql += " joindate, point) values(?,?,?,?,?,?,?,sysdate,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getMemberid());
			pstmt.setString(2, member.getPassword());
			pstmt.setString(3, member.getName());
			pstmt.setInt(4, member.getBirthday());
			pstmt.setString(5, member.getSch_emt());
			pstmt.setString(6, member.getSch_mid());
			pstmt.setString(7, member.getSch_high());
			pstmt.setInt(8, 10);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			close(con, pstmt, rs);
		}

	}
	
	public int getMemberCount(String sch_emt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql=null;
		int number = 0;
		try {
			con=getConnection();
			sql = "select nvl(count(*),0) from member where sch_emt = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sch_emt);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				number = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			close(con, pstmt, rs);
		}
		return number;
	}

	// 게시글 리스트에 뽑아내는 메소드(2)
	public List getMembers(int startRow, int endRow, String sch_emt) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List memberList = null;
		String sql = "";
		try {
			conn = getConnection();
			sql = " select * from (select rownum rnum ,a.* from "
					+ "(select password,name,email,sch_emt,sch_mid,"
					+ "sch_high, content, birthday, num "
					+ "from member where sch_emt = ?) "
					+ "a ) where rnum  between ? and ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sch_emt);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				memberList = new ArrayList();
				do {
					MemberVO member = new MemberVO();
					member.setBirthday(rs.getInt("birthday"));
					member.setName(rs.getString("name"));
					member.setSch_emt(rs.getString("sch_emt"));
					member.setSch_mid(rs.getString("sch_mid"));
					member.setSch_high(rs.getString("sch_high"));
					member.setPassword(rs.getString("password"));
					memberList.add(member);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return memberList;
	}

	// 리스트에서 선택된 글 뽑아내는 메소드 chk에 따라 수정이냐 아니냐
	public MemberVO getMember(int num, String boardid, String chk) {
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO member = null;
		String sql = "";
		try {
			conn = getConnection();
			//컨텐트에서 보낼때 수정하고, update에서 보낼땐 리스트가 보이게끔
			if (chk.equals("content")) {
				sql = "update board set readcount = readcount +1 where num=? and boardid =?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, boardid);
				pstmt.executeUpdate();
			}
			sql = "select * from board where num =? and boardid =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, boardid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				member = new MemberVO();
				member.setBirthday(rs.getInt("birthday"));
				member.setName(rs.getString("name"));
				member.setSch_emt(rs.getString("sch_emt"));
				member.setSch_mid(rs.getString("sch_mid"));
				member.setSch_high(rs.getString("sch_high"));
				
				}
		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return member;
	}

	// 게시글 수정하는 메소드
	public int updatemember(MemberVO member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int updateCount = 0;

		try {
			conn = getConnection();
			String sql = "update board set writer=?, email=?,subject=?, ";
			sql += "content=? where num=? and passwd=?";
			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, member.getWriter());
//			pstmt.setString(2, member.getEmail());
//			pstmt.setString(3, member.getSubject());
//			pstmt.setString(4, member.getContent());
//			pstmt.setInt(5, member.getNum());
//			pstmt.setString(6, member.getPasswd());
//			updateCount = pstmt.executeUpdate();

		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			close(conn, pstmt, null);
		}
		return updateCount;
	}
	
	//게시글 삭제 메소드
	public int deletemember(int num, String passwd, String boardid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int deleteNum = -1;

		try {
			conn = getConnection();
			String sql = "delete from board where num=? and passwd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, passwd);
			deleteNum = pstmt.executeUpdate();

		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			close(conn, pstmt, null);
		}
		return deleteNum;
	}
	
	
	
}
