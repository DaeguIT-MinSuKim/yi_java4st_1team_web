package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import hairrang_web.dao.NoticeDao;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Notice;
import hairrang_web.utils.Paging;

public class NoticeDaoImpl implements NoticeDao {
	private static final NoticeDaoImpl instance = new NoticeDaoImpl();

	public static NoticeDaoImpl getInstance() {
		return instance;
	}

	private NoticeDaoImpl() {
	}

	@Override
	public int countNoitce() {
		String sql = "SELECT COUNT(*) AS COUNT FROM NOTICE";
		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {
				return rs.getInt("COUNT");
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return 0;
	}

	@Override
	public int countDelNotice() {
		String sql = "SELECT COUNT(*) AS COUNT FROM NOTICE WHERE NOTICE_DELYN ='y'";
		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {
				return rs.getInt("COUNT");
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return 0;
	}

	@Override
	public List<Notice> selectPagingNotice(Paging paging) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM notice WHERE notice_delyn = 'n'  ORDER BY notice_no DESC) a) WHERE rn BETWEEN ? AND ?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, paging.getStart());
			pstmt.setInt(2, paging.getEnd());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					List<Notice> list = new ArrayList<Notice>();
					do {
						list.add(getNotice(rs));
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
	public List<Notice> selectPagingDelNotice(Paging paging) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM notice WHERE notice_delyn = 'y'  ORDER BY notice_no DESC) a) WHERE rn BETWEEN ? AND ?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, paging.getStart());
			pstmt.setInt(2, paging.getEnd());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					List<Notice> list = new ArrayList<Notice>();
					do {
						list.add(getNotice(rs));
					} while (rs.next());
					return list;
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	private Notice getNotice(ResultSet rs) throws SQLException {
		int noticeNo = rs.getInt("notice_no");
		String noticeTitle = rs.getString("notice_title");
		String noticeContent = rs.getString("notice_content");
		String noticeFile = rs.getString("notice_file");
		String noticeDelYn = rs.getString("NOTICE_DELYN");

		return new Notice(noticeNo, noticeTitle, noticeContent, noticeDelYn, noticeFile);
	}

	@Override
	public Notice selectNoticeByNo(int noticeNo) {
		String sql = "SELECT * FROM notice WHERE notice_no =?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, noticeNo);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					do {
						return getNotice(rs);
					} while (rs.next());
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public Notice selectNoticeDownSide(Notice notice) {
		String sql = "SELECT * FROM (SELECT * FROM notice WHERE notice_NO <? ORDER BY notice_NO DESC ) WHERE rownum = 1";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, notice.getNoticeNo());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return getNotice(rs);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public Notice selectNoticeUpSide(Notice notice) {
		String sql = "SELECT * FROM (SELECT * FROM notice WHERE notice_NO > ? ) WHERE rownum = 1";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, notice.getNoticeNo());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return getNotice(rs);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public List<Notice> NoticeAll() {
		String sql = "SELECT * FROM notice ORDER BY notice_NO DESC";
		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {
				ArrayList<Notice> list = new ArrayList<Notice>();
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

	@Override
	public int deleteNotice(Notice notice) {
		String sql = "UPDATE NOTICE SET NOTICE_DELYN ='y' WHERE NOTICE_NO =?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, notice.getNoticeNo());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int insertNotice(Notice notice) {
		String sql = "INSERT INTO NOTICE(NOTICE_TITLE,NOTICE_CONTENT,NOTICE_FILE) VALUES(?,?,?)";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, notice.getNoticeTitle());
			pstmt.setString(2, notice.getNoticeContent());
			pstmt.setString(3, notice.getNoticeFile());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int updateNotice(Notice notice) {
		String sql = "UPDATE NOTICE SET NOTICE_TITLE=?, NOTICE_CONTENT=? WHERE NOTICE_NO =?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, notice.getNoticeTitle());
			pstmt.setString(2, notice.getNoticeContent());
			pstmt.setInt(3, notice.getNoticeNo());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int RestoreNotice(String no) {
		String sql = "UPDATE NOTICE SET NOTICE_DELYN ='n' WHERE NOTICE_NO =?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, no);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	//삭제 안된 공지 찾기
	@Override
	public int countPagingNoticeSearch(Paging paging, String condition, String keyword, String stay) {
		String sql = "SELECT COUNT(*) AS COUNT FROM NOTICE";

		if (stay.equals("all")) {
			sql += " where NOTICE_DELYN ='n'";
		} else if (stay.equals("del")) {
			sql += " where NOTICE_DELYN ='y' ";
		}

		if (condition != null ) {
			sql += " and";
			if (condition.equalsIgnoreCase("noticeTitle")) {
				condition = " notice_title";
				sql += condition + " like '%"+ keyword + "%'";
			} else if (condition.equalsIgnoreCase("noticeContent")) {
				condition = "notice_content";
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
	public List<Notice> selectPagingNoticeSearch(Paging paging, String condition, String keyword, String stay) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM notice";

		if (stay.equals("all")) {
			sql += " where NOTICE_DELYN ='n'";
		} else if (stay.equals("del")) {
			sql += " where NOTICE_DELYN ='y'";
		}

		if (condition != null) {
			sql += " and";
			if (condition.equalsIgnoreCase("noticeTitle")) {
				condition = " notice_title ";
				sql += condition + " like '%"+ keyword + "%'";
			} else if (condition.equalsIgnoreCase("noticeContent")) {
				condition = " notice_content ";
				sql += condition + " like '%" + keyword + "%'";
			}
		}

		sql += " ORDER BY notice_no DESC) a) WHERE rn BETWEEN ? AND ?";
		System.out.println("완성된 sql :" + sql);

		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, paging.getStart());
			pstmt.setInt(2, paging.getEnd());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					List<Notice> list = new ArrayList<Notice>();
					do {
						list.add(getNotice(rs));
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
