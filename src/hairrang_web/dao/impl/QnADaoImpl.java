package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import hairrang_web.dao.QnADao;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Admin;
import hairrang_web.dto.Guest;
import hairrang_web.dto.QnA;
import hairrang_web.utils.Paging;

public class QnADaoImpl implements QnADao {
	private static final QnADaoImpl instance = new QnADaoImpl();

	public static QnADaoImpl getInstance() {
		return instance;
	}

	private QnADaoImpl() {
	}

	
	@Override
	public ArrayList<QnA> selctQnaAll() {
		String sql = "SELECT QNA_NO,QNA_TITLE,QNA_REGDATE,RES_YN FROM QNA_VIEW ORDER BY QNA_NO DESC";
		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {
				ArrayList<QnA> list = new ArrayList<QnA>();
				do {
					list.add(getQnA(rs));
				} while (rs.next());
				return list;
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	private QnA getQnA(ResultSet rs) throws SQLException {
		//SELECT QNA_NO,QNA_TITLE,QNA_CONTENT,QNA_FILE,QNA_REGDATE,RES_YN FROM QNA WHERE GUEST_ID = ? ORDER BY QNA_NO DESC";
		
		QnA qna = new QnA();
		qna.setQnaNo(rs.getInt("QNA_NO"));
		qna.setQnaTitle(rs.getString("QNA_TITLE"));
		qna.setQnaRegDate(rs.getTimestamp("QNA_REGDATE").toLocalDateTime());
		try {
			qna.setQnaContent(rs.getString("QNA_CONTENT"));	
			qna.setGuestId(new Guest(rs.getString("GUEST_ID")));
			qna.setQnaSecret(rs.getString("QNA_SECRET"));
			qna.setQnaPassword(rs.getString("QNA_PASSWORD"));
		} catch(SQLException e) {
		}
		qna.setQnaResYn(rs.getString("RES_YN"));

		qna.setQnaFile(rs.getString("QNA_FILE"));
		
		return qna;
	}

	@Override
	public QnA selectQnAByIdNo(int qnaNo) {
		String sql = "SELECT * FROM QNA WHERE QNA_NO =?";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setInt(1,qnaNo);
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					do {
						return getQnA(rs);
					}while(rs.next());
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public int insertQnA(QnA qna) {
		String sql = "INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,RES_YN,QNA_FILE) VALUES (?,?,?,'n',?)";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, qna.getGuestId().getGuestId());
			pstmt.setString(2, qna.getQnaTitle());
			pstmt.setString(3, qna.getQnaContent());
			pstmt.setString(4, qna.getQnaFile());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int updateQnA(QnA qna) {
		String sql = "UPDATE QNA  " + 
				"	SET QNA_CONTENT = ?, " + 
				"		QNA_REGDATE = SYSDATE  " + 
				"	WHERE QNA_NO = ?";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, qna.getQnaContent());
			pstmt.setInt(2, qna.getQnaNo());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int deleteQnA(QnA qna) {
		String sql = "DELETE FROM QNA WHERE QNA_NO = ?";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setInt(1, qna.getQnaNo());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int checkPwd() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<QnA> selectNoticeAll() {
		String sql = "SELECT QNA_NO,ADMIN_ID,QNA_TITLE,QNA_CONTENT,QNA_FILE,QNA_REGDATE,DEL_YN FROM QNA WHERE GUEST_ID IS NULL";
		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {
				ArrayList<QnA> list = new ArrayList<QnA>();
				do {
					list.add(getNotice(rs));
				} while (rs.next());
				return list;
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	private QnA getNotice(ResultSet rs) throws SQLException {
		QnA qna = new QnA();
		qna.setQnaNo(rs.getInt("QNA_NO"));
		qna.setAdminId(new Admin(rs.getString("ADMIN_ID")));
		qna.setQnaTitle(rs.getString("QNA_TITLE"));
		qna.setQnaContent(rs.getString("QNA_CONTENT"));
		qna.setQnaFile(rs.getString("QNA_FILE"));
		qna.setQnaRegDate(rs.getTimestamp("QNA_REGDATE").toLocalDateTime());
		qna.setQnaDelYn(rs.getString("DEL_YN"));
		return qna;
	}

	@Override
	public ArrayList<QnA> selectQnaAllById(Guest guest) {
		String sql = "SELECT QNA_NO,QNA_TITLE,QNA_CONTENT,QNA_FILE,QNA_REGDATE,RES_YN FROM QNA WHERE GUEST_ID = ? ORDER BY QNA_NO DESC";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, guest.getGuestId());
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					ArrayList<QnA> list = new ArrayList<QnA>();
					do {
						list.add(getQnA(rs));
					} while (rs.next());
					return list;
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public int nextQnaNo() {
		String sql = "SELECT QNA_NO_SEQ.CURRVAL+1 AS count FROM DUAL";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()){
			if(rs.next()) {
				return rs.getInt("count");
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return 0;
	}

	@Override
	public int countQnA() {
		String sql = "SELECT COUNT(*) AS count FROM QNA";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()){
			if(rs.next()) {
				return rs.getInt("count");
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return 0;
	}

	@Override
	public List<QnA> selectPagingQnA(Paging paging) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM QNA  ORDER BY notice_yn DESC,QNA_NO DESC ) a) WHERE QNA_REFNO IS NULL AND rn BETWEEN ? AND ?";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, paging.getStart());
			pstmt.setInt(2, paging.getEnd());
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					List<QnA> list = new ArrayList<QnA>();
					do {
						list.add(getQnA(rs));
					} while (rs.next());
					return list;
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public QnA selectResByNo(QnA qna) {
		String sql = "SELECT * FROM qna WHERE QNA_REFNO = ?";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setInt(1,qna.getQnaNo());
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					do {
						return getQnA(rs);
					}while(rs.next());
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

}
