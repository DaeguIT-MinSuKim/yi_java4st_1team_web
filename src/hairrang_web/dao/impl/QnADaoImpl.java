package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;

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

	// 총 글 갯수
	@Override
	public int countQnA() {
		String sql = "SELECT COUNT(*) AS count FROM QNA WHERE DEL_YN = 'n' and ADMIN_ID is null or NOTICE_YN ='y' AND DEL_YN ='n'";
		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {
				return rs.getInt("count");
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return 0;
	}

	// 총 글 페이징
	@Override
	public List<QnA> selectPagingQnA(Paging paging) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM QNA WHERE DEL_YN ='n' and ADMIN_ID IS NULL or NOTICE_YN ='y' AND DEL_YN ='n' ORDER BY notice_yn DESC,QNA_NO DESC ) a) WHERE QNA_REFNO IS NULL AND rn BETWEEN ? AND ?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, paging.getStart());
			pstmt.setInt(2, paging.getEnd());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
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

	// 답변한 문의 갯수
	@Override
	public int countResYQnA() {
		String sql = "SELECT COUNT(*) AS count FROM QNA WHERE RES_YN = 'y'";
		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {
				return rs.getInt("count");
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return 0;
	}

	// 답변한 문의 페이징
	@Override
	public List<QnA> selectPagingResYQnA(Paging paging) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM QNA WHERE RES_YN = 'y' AND NOTICE_YN ='n'  ORDER BY notice_yn DESC,QNA_NO DESC ) a) WHERE QNA_REFNO IS NULL AND rn BETWEEN ? AND ?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, paging.getStart());
			pstmt.setInt(2, paging.getEnd());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
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

	// 미답변 문의 갯수
	@Override
	public int countResNQnA() {
		String sql = "SELECT COUNT(*) AS count FROM QNA WHERE RES_YN = 'n' AND ADMIN_ID IS NULL OR NOTICE_YN ='n'";
		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {
				return rs.getInt("count");
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return 0;
	}

	// 미답변 문의 페이징
	@Override
	public List<QnA> selectPagingResNQnA(Paging paging) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM QNA WHERE RES_YN = 'n' AND NOTICE_YN ='n'  ORDER BY notice_yn DESC,QNA_NO DESC ) a) WHERE QNA_REFNO IS NULL AND rn BETWEEN ? AND ?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, paging.getStart());
			pstmt.setInt(2, paging.getEnd());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
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

	// 삭제된 문의 갯수
	@Override
	public int countDelYQnA() {
		String sql = "SELECT COUNT(*) AS count FROM QNA WHERE DEL_YN = 'y' AND ADMIN_ID IS NULL AND NOTICE_YN ='n'";
		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {
				return rs.getInt("count");
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return 0;
	}

	// 삭제된 문의 페이징
	@Override
	public List<QnA> selectPagingDelYQnA(Paging paging) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM QNA WHERE DEL_YN = 'y' AND NOTICE_YN ='n'  ORDER BY notice_yn DESC,QNA_NO DESC ) a) WHERE QNA_REFNO IS NULL AND rn BETWEEN ? AND ?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, paging.getStart());
			pstmt.setInt(2, paging.getEnd());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
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

	// 삭제된 문의공지 갯수
	@Override
	public int countDelYQnANotice() {
		String sql = "SELECT COUNT(*) AS count FROM QNA WHERE DEL_YN = 'y'AND NOTICE_YN ='y'";
		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {
				return rs.getInt("count");
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return 0;
	}

	// 삭제된 문의공지 페이징
	@Override
	public List<QnA> selectPagingDelYQnANotice(Paging paging) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM QNA WHERE DEL_YN = 'y' AND NOTICE_YN ='y'  ORDER BY notice_yn DESC,QNA_NO DESC ) a) WHERE QNA_REFNO IS NULL AND rn BETWEEN ? AND ?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, paging.getStart());
			pstmt.setInt(2, paging.getEnd());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
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

	private QnA getQnA(ResultSet rs) throws SQLException {
		// SELECT QNA_NO,QNA_TITLE,QNA_CONTENT,QNA_FILE,QNA_REGDATE,RES_YN FROM QNA
		// WHERE GUEST_ID = ? ORDER BY QNA_NO DESC";

		QnA qna = new QnA();
		qna.setQnaNo(rs.getInt("QNA_NO"));
		qna.setQnaTitle(rs.getString("QNA_TITLE"));
		qna.setQnaRegDate(rs.getTimestamp("QNA_REGDATE").toLocalDateTime());
		try {
			qna.setQnaContent(rs.getString("QNA_CONTENT"));
			qna.setGuestId(new Guest(rs.getString("GUEST_ID")));
			qna.setQnaSecret(rs.getString("QNA_SECRET"));
			qna.setQnaPassword(rs.getString("QNA_PASSWORD"));
		} catch (SQLException e) {
		}
		qna.setQnaResYn(rs.getString("RES_YN"));
		qna.setQnaDelYn(rs.getString("DEL_YN"));
		qna.setQnaFile(rs.getString("QNA_FILE"));
		qna.setQnaNotice(rs.getString("NOTICE_YN"));

		return qna;
	}

	@Override
	public QnA selectQnAByIdNo(int qnaNo) {
		String sql = "SELECT * FROM QNA WHERE QNA_NO =?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, qnaNo);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					do {
						return getQnA(rs);
					} while (rs.next());
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public int insertQnA(QnA qna) {
		String sql = "INSERT INTO QNA (GUEST_ID,GUEST_NAME,QNA_TITLE,QNA_CONTENT,QNA_FILE,QNA_PASSWORD,QNA_SECRET) VALUES (?,?,?,?,?,?,?)";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			if (qna.getGuestId() == null) {
				pstmt.setString(1, null);

			} else {
				pstmt.setString(1, qna.getGuestId().getGuestId());
				pstmt.setString(2, qna.getGuestId().getGuestName());
			}
			pstmt.setString(3, qna.getQnaTitle());
			pstmt.setString(4, qna.getQnaContent());
			pstmt.setString(5, qna.getQnaFile());
			pstmt.setString(6, qna.getQnaPassword());
			pstmt.setString(7, qna.getQnaSecret());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int updateQnA(QnA qna) {
		String sql = "UPDATE QNA  " + "	SET QNA_CONTENT = ?, " + "		QNA_REGDATE = SYSDATE  "
				+ "	WHERE QNA_NO = ?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, qna.getQnaContent());
			pstmt.setInt(2, qna.getQnaNo());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int deleteQnA(QnA qna) {
		String sql = "UPDATE QNA SET DEL_YN ='y' WHERE QNA_NO = ?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, qna.getQnaNo());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public QnA checkPwd(QnA qna) {
		String sql = "SELECT * FROM QNA WHERE QNA_NO =? AND QNA_PASSWORD = ? ";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, qna.getQnaNo());
			pstmt.setString(2, qna.getQnaPassword());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return getQnA(rs);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
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
		String sql = "SELECT QNA_NO,GUEST_ID,GUEST_NAME,ADMIN_ID,QNA_TITLE,QNA_CONTENT,QNA_FILE,QNA_REGDATE,RES_YN,QNA_REFNO,NOTICE_YN,DEL_YN,QNA_SECRET,QNA_PASSWORD FROM QNA WHERE GUEST_ID = ? ORDER BY QNA_NO DESC";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, guest.getGuestId());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
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
		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {
				return rs.getInt("count");
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return 0;
	}

	@Override
	public QnA selectResByNo(QnA qna) {
		String sql = "SELECT * FROM qna WHERE QNA_REFNO = ?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, qna.getQnaNo());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					do {
						return getQnA(rs);
					} while (rs.next());
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public int countQnaById(String id) {
		String sql = "SELECT COUNT(*) FROM qna WHERE GUEST_ID = ? ";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, id);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return rs.getInt(1);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}

		return 0;

	}

	@Override
	public List<QnA> pagingQnaById(Paging paging, String id) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM qna WHERE GUEST_ID = ? ORDER BY qna_no desc) a) "
				+ "WHERE rn BETWEEN ? AND ? ORDER BY rn";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, id);
			pstmt.setInt(2, paging.getStart());
			pstmt.setInt(3, paging.getEnd());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
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
	public int insertQnaNotice(QnA qna) {
		String sql = "INSERT INTO QNA(ADMIN_ID, QNA_TITLE, QNA_CONTENT, QNA_FILE, NOTICE_YN) VALUES(?,?,?,?,'y')";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, qna.getAdminId().getAdminId());
			pstmt.setString(2, qna.getQnaTitle());
			pstmt.setString(3, qna.getQnaContent());
			pstmt.setString(4, qna.getQnaFile());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}

	}

	@Override
	public int updateResult(QnA qna) {
		String sql = "UPDATE QNA  set QNA_TITLE = ?, QNA_CONTENT = ?, QNA_FILE = ?  WHERE QNA_NO = ?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, qna.getQnaTitle());
			pstmt.setString(2, qna.getQnaContent());
			pstmt.setString(3, qna.getQnaFile());
			pstmt.setInt(4, qna.getQnaNo());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int updateRestoreQna(String no) {
		String sql = "UPDATE QNA  set DEL_YN = 'n'  WHERE QNA_NO = ?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, no);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int countPagingQnaSearch(String condition, String keyword, String stay) {
		String sql = "SELECT COUNT(*) AS count FROM QNA WHERE ";

		System.out.println("sql에서 검색조건==>" + condition);
		System.out.println("sql에서 검색어==>" + keyword);

		if (stay.equals("all")) {
			sql += " DEL_YN = 'n' AND QNA_REFNO is null ";
		} else if (stay.equals("resy")) {
			sql += " DEL_YN = 'n' AND ADMIN_ID IS NULL and RES_YN ='y' ";
		} else if (stay.equals("resn")) {
			sql += " DEL_YN = 'n' AND ADMIN_ID IS NULL and RES_YN ='n' ";
		} else if (stay.equals("delq")) {
			sql += " DEL_YN = 'y' AND NOTICE_YN ='n' ";
		} else if (stay.equals("deln")) {
			sql += " DEL_YN = 'y' AND NOTICE_YN ='y' ";
		}

		if (condition != null) {
			sql += " and";
			if (condition.equalsIgnoreCase("qnaTitle")) {
				System.out.println("검색조건이 있음");
				condition = " QNA_TITLE ";
				sql += condition + " like '%" + keyword + "%'";
			} else if (condition.equalsIgnoreCase("qnaContent")) {
				condition = " QNA_CONTENT ";
				sql += condition + " like '%" + keyword + "%'";
			} else if (condition.equalsIgnoreCase("qnaWriter")) {
				condition = " GUEST_ID ";
				sql += condition + " like '%" + keyword + "%'";
			}
		}

		System.out.println("완성된 sql :" + sql);

		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return 0;
	}

	@Override
	public List<QnA> selectPagingQnASearch(Paging paging, String condition, String keyword, String stay) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.QNA_NO,GUEST_ID,GUEST_NAME,ADMIN_ID,QNA_TITLE,QNA_CONTENT,QNA_FILE, QNA_REGDATE,RES_YN,QNA_REFNO,NOTICE_YN,DEL_YN,QNA_SECRET,QNA_PASSWORD FROM (SELECT * FROM QNA where ";

		if (stay.equals("all")) {
			sql += " DEL_YN = 'n' AND QNA_REFNO is null ";
		} else if (stay.equals("resy")) {
			sql += " DEL_YN = 'n' AND ADMIN_ID IS NULL and RES_YN ='y' ";
		} else if (stay.equals("resn")) {
			sql += " DEL_YN = 'n' AND ADMIN_ID IS NULL and RES_YN ='n' ";
		} else if (stay.equals("delq")) {
			sql += " DEL_YN = 'y' AND NOTICE_YN ='n' ";
		} else if (stay.equals("deln")) {
			sql += " DEL_YN = 'y' AND NOTICE_YN ='y' ";
		}

		if (condition != null) {
			sql += " and";
			if (condition.equalsIgnoreCase("qnaTitle")) {
				condition = " QNA_TITLE ";
				sql += condition + " like '%" + keyword + "%'";
			} else if (condition.equalsIgnoreCase("qnaContent")) {
				condition = " QNA_CONTENT ";
				sql += condition + " like '%" + keyword + "%'";
			} else if (condition.equalsIgnoreCase("qnaWriter")) {
				condition = " GUEST_ID ";
				sql += condition + " like '%" + keyword + "%'";
			}
		}

		sql += " ORDER BY notice_yn DESC,QNA_NO DESC ) a) WHERE rn BETWEEN ? AND ? ";
		System.out.println("완성된 sql :" + sql);

		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, paging.getStart());
			pstmt.setInt(2, paging.getEnd());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
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
}
