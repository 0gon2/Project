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
	//학교정보 수정
	public int updateArticle(MemberVO article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int updateCount = 0;

		try {
			conn = getConnection();
			String sql = "update member set sch_emt=?, sch_mid=?,sch_high=? where memberid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getSch_emt());
			pstmt.setString(2, article.getSch_mid());
			pstmt.setString(3, article.getSch_high());
			pstmt.setString(4, article.getMemberid());
			updateCount = pstmt.executeUpdate();

		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			close(conn, pstmt, null);
		}
		return updateCount;
	}
	
	//회원 탈퇴
	public void deleteArticle(String memberid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "delete from member where memberid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberid);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			close(conn, pstmt, null);
		}
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
	
	//로그인
	public int login(String memberid, String password) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT password FROM member WHERE memberid=?";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberid);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(password)) {
					return 1;	//로그인 성공
				}
				else {
					return 0;	//비밀번호 불일치
				}
			}
			return -1; //아이디가 없다
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류
	}
	
	//회원등록 메소드
	public void insertMember(MemberVO member) {
		Connection con = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int number = 0;
		try {
			sql = "insert into member(memberid, password,name,birthday,sch_emt,sch_mid,sch_high,";
			sql += " joindate, point, emtid, midid, highid) values(?,?,?,?,?,?,?,sysdate,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getMemberid());
			pstmt.setString(2, member.getPassword());
			pstmt.setString(3, member.getName());
			pstmt.setInt(4, member.getBirthday());
			pstmt.setString(5, member.getSch_emt());
			pstmt.setString(6, member.getSch_mid());
			pstmt.setString(7, member.getSch_high());
			pstmt.setInt(8, 10);
			pstmt.setString(9, member.getEmtid());
			pstmt.setString(10, member.getMidid());
			pstmt.setString(11, member.getHighid());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			close(con, pstmt, rs);
		}

	}
	//친구관계 테이블에 회원 추가
	public void requestFriend(relationVO article) {
		Connection con = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int number = 0;
		try {
			sql = "insert into relation(myid, otherid, status) values(?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article.getMyId());
			pstmt.setString(2, article.getOtherId());
			pstmt.setInt(3, 1);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			close(con, pstmt, rs);
		}

	}
	
	
	public void defaultRelation(String myId) {
		Connection con = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int number = 0;
		try {
			sql = "insert into relation(myid, otherid, status) values(?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, myId);
			pstmt.setString(2, myId);
			pstmt.setInt(3, 1);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			close(con, pstmt, rs);
		}

	}
	
	
	
	//학교 명단 추출하는 메소드
	@SuppressWarnings("resource")
	public List getSchoolmate(int startRow, int endRow, String sname, String sclass) {
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articleList = null;
		String sql = "";
		
		try {
			conn = getConnection();
			if(sclass.equals("초등학교")) {
				sql = " select * from (select rownum rnum ,a.* from "
						+ "(select m.name, m.birthday,m.joindate, m.memberid, "
						+ "m.sch_emt, m.sch_mid, m.sch_high"
						+ " from MEMBER m, SCHOOL s where m.emtid=s.sid and m.sch_emt=? "
						+ "order by joindate desc) "
						+ "	a ) where rnum  between ? and ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, sname);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
				
			}
			if(sclass.equals("중학교")) {
				sql = " select * from (select rownum rnum ,a.* from "
						+ "(select m.name, m.birthday,m.joindate, m.memberid, "
						+ "m.sch_emt, m.sch_mid, m.sch_high"
						+ " from MEMBER m, SCHOOL s where m.emtid=s.sid and m.sch_mid=? "
						+ "order by joindate desc) "
						+ "	a ) where rnum  between ? and ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, sname);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			if(sclass.equals("고등학교")) {
				sql = " select * from (select rownum rnum ,a.* from "
						+ "(select m.name, m.birthday,m.joindate, m.memberid, "
						+ "m.sch_emt, m.sch_mid, m.sch_high"
						+ " from MEMBER m, SCHOOL s where m.emtid=s.sid and m.sch_high=? "
						+ "order by joindate desc) "
						+ "	a ) where rnum  between ? and ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, sname);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
		
			rs = pstmt.executeQuery();
			if (rs.next()) {
				articleList = new ArrayList();
				do {
					SmemberVO article = new SmemberVO();
					article.setName(rs.getString("name"));
					article.setBirthday(rs.getInt("birthday"));
					article.setJoindate(rs.getDate("joindate"));
					article.setMemberid(rs.getString("memberid"));
					article.setSch_emt(rs.getString("sch_emt"));
					article.setSch_mid(rs.getString("sch_mid"));
					article.setSch_high(rs.getString("sch_high"));
					articleList.add(article);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return articleList;
	}
	
	
	
	
	//회원전체 리스트 
	public List getAllmember(int startRow, int endRow) {
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articleList = null;
		String sql = "";
		try {
			conn = getConnection();
			sql = " select * from (select rownum rnum ,a.* from "
					+ "(select *"
					+ " from member order by joindate desc) "
					+ "	a ) where rnum  between ? and ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				articleList = new ArrayList();
				do {
					MemberVO article = new MemberVO();
					article.setMemberid(rs.getString("memberid"));
					article.setPassword(rs.getString("password"));
					article.setName(rs.getString("name"));
					article.setBirthday(rs.getInt("birthday"));
					article.setJoindate(rs.getDate("joindate"));
					article.setSch_emt(rs.getString("sch_emt"));
					article.setSch_mid(rs.getString("sch_mid"));
					article.setSch_high(rs.getString("sch_high"));
					articleList.add(article);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return articleList;
	}
	//동창 인원수 체크
	@SuppressWarnings("resource")
	public int getSchoolmateCount(String sclass, String schemt, String schmid, String schhigh) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql=null;
		int number = 0;
		try {
			con=getConnection();
			if(sclass.equals("초등학교")) {
				sql = "select nvl(count(*),0) from "
						+ "(SELECT m.name, m.birthday,m.joindate " + 
						"from MEMBER m, SCHOOL s "
						+ "where m.emtid=s.sid and m.sch_emt=?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, schemt);
			}
			if(sclass.equals("중학교")) {
				sql = "select nvl(count(*),0) from "
						+ "(SELECT m.name, m.birthday,m.joindate " + 
						"from MEMBER m, SCHOOL s "
						+ "where m.emtid=s.sid and m.sch_mid=?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, schmid);
			}
			if(sclass.equals("고등학교")) {
				sql = "select nvl(count(*),0) from "
						+ "(SELECT m.name, m.birthday,m.joindate " + 
						"from MEMBER m, SCHOOL s "
						+ "where m.emtid=s.sid and m.sch_high=?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, schhigh);
			}
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
	
	
	
	
	
	
	//전체 회원 수 카운팅
	public int getMemberCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql=null;
		int number = 0;
		try {
			con=getConnection();
			sql = "select nvl(count(*),0) from member";
			pstmt = con.prepareStatement(sql);
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

	
	public MemberVO getUserInfo(String memberid) {
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO article = null;
		String sql = "";
		try {
			conn = getConnection();
			sql = "select name,sch_emt, sch_mid, sch_high, birthday "
					+ "from member where memberid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,memberid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				article = new MemberVO();
				article.setName(rs.getString("name"));
				article.setSch_emt(rs.getString("sch_emt"));
				article.setSch_mid(rs.getString("sch_mid"));
				article.setSch_high(rs.getString("sch_high"));
				article.setBirthday(rs.getInt("birthday"));
				}
		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return article;
	}

	
}
