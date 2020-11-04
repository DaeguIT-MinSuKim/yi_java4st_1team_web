package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.JSONArray;

import hairrang_web.dao.ChartDao;
import hairrang_web.ds.JndiDs;

public class ChartDaoImpl implements ChartDao {
	private static final ChartDaoImpl instance = new ChartDaoImpl();

	public static ChartDaoImpl getInstance() {
		return instance;
	}

	private ChartDaoImpl() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public JSONArray qnaByoneDay(String year) {
		String sql = null;
		if (year.equals("all")) {
			sql = "SELECT TO_CHAR(QNA_REGDATE,'yyyy') AS day ,COUNT(*)AS count FROM qna WHERE ADMIN_ID IS NULL  GROUP BY TO_CHAR(QNA_REGDATE,'yyyy') ORDER BY TO_CHAR(QNA_REGDATE,'yyyy')";
		} else {
			sql = "SELECT TO_CHAR(QNA_REGDATE,'mm') AS day ,COUNT(*)AS count FROM qna WHERE ADMIN_ID IS NULL ";
			if (year != null) {
				sql += " AND TO_CHAR(QNA_REGDATE,'yyyy') = " + year + " ";
			}
			sql += " GROUP BY TO_CHAR(QNA_REGDATE,'mm') ORDER BY TO_CHAR(QNA_REGDATE,'mm')";
		}

		JSONArray jsonArray = new JSONArray();

		JSONArray colNameArray = new JSONArray();
		colNameArray.put("Day");
		colNameArray.put("문의수");
		jsonArray.put(colNameArray);

		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {

				do {
					JSONArray rowArray = new JSONArray();
					rowArray.put(rs.getString("day"));
					rowArray.put(rs.getInt("count"));
					jsonArray.put(rowArray);
				} while (rs.next());
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return jsonArray;
	}

	@Override
	public JSONArray qnaByRes(String year) {
		String sql = null;
		if (year.equals("all")) {
			sql = "SELECT RES_YN ,COUNT(*)AS count FROM qna ";
		} else {
			sql = "SELECT RES_YN ,COUNT(*)AS count FROM qna ";
			if (year != null) {
				sql += " WHERE TO_CHAR(QNA_REGDATE,'yyyy') = " + year + " ";
			}
		}

		sql += "GROUP BY RES_YN ORDER BY RES_YN";

		JSONArray jsonArray = new JSONArray();

		JSONArray colNameArray = new JSONArray();
		colNameArray.put("Result");
		colNameArray.put("답변");
		jsonArray.put(colNameArray);

		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {

				do {
					JSONArray rowArray = new JSONArray();
					rowArray.put(rs.getString("RES_YN"));
					rowArray.put(rs.getInt("count"));
					jsonArray.put(rowArray);
				} while (rs.next());
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return jsonArray;
	}

	@Override
	public JSONArray qnaBySecret(String year) {
		String sql = null;
		if (year.equals("all")) {
			sql = "SELECT QNA_SECRET ,COUNT(*)AS count FROM qna ";
		} else {
			sql = "SELECT QNA_SECRET ,COUNT(*)AS count FROM qna ";
			if (year != null) {
				sql += " WHERE TO_CHAR(QNA_REGDATE,'yyyy') = " + year + " ";
			}
		}

		sql += "GROUP BY QNA_SECRET ORDER BY QNA_SECRET";

		JSONArray jsonArray = new JSONArray();

		JSONArray colNameArray = new JSONArray();
		colNameArray.put("Secret");
		colNameArray.put("비밀");
		jsonArray.put(colNameArray);

		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {

				do {
					JSONArray rowArray = new JSONArray();
					rowArray.put(rs.getString("QNA_SECRET"));
					rowArray.put(rs.getInt("count"));
					jsonArray.put(rowArray);
				} while (rs.next());
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return jsonArray;
	}

	@Override
	public JSONArray guestByJoin(String year) {
		String sql = null;
		if (year.equals("all")) {
			sql = "SELECT TO_CHAR(GUEST_JOIN_DATE,'yyyy')AS day ,COUNT(*)AS count FROM GUEST  GROUP BY TO_CHAR(GUEST_JOIN_DATE,'yyyy') ORDER BY TO_CHAR(GUEST_JOIN_DATE,'yyyy')";
		} else {
			sql = "SELECT TO_CHAR(GUEST_JOIN_DATE,'mm')AS day ,COUNT(*)AS count FROM GUEST ";
			if (year != null) {
				sql += " WHERE TO_CHAR(GUEST_JOIN_DATE,'yyyy') = " + year + " GROUP BY TO_CHAR(GUEST_JOIN_DATE,'mm') ORDER BY TO_CHAR(GUEST_JOIN_DATE,'mm')";
			}
		}
		
		JSONArray jsonArray = new JSONArray();

		JSONArray colNameArray = new JSONArray();
		colNameArray.put("Day");
		colNameArray.put("가입 인원수");
		jsonArray.put(colNameArray);

		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {

				do {
					JSONArray rowArray = new JSONArray();
					rowArray.put(rs.getString("day"));
					rowArray.put(rs.getInt("count"));
					jsonArray.put(rowArray);
				} while (rs.next());
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return jsonArray;
	}


	@Override
	public JSONArray guestByGender(String year) {
		String sql = null;
		if (year.equals("all")) {
			sql = "SELECT GUEST_GENDER ,COUNT(*)AS count FROM GUEST";
		} else {
			sql = "SELECT GUEST_GENDER ,COUNT(*)AS count FROM ";
			if (year != null) {
				sql += "(SELECT * FROM GUEST WHERE TO_CHAR(GUEST_JOIN_DATE,'yyyy') = " + year + " AND DEL_YN = 'n') ";
			}
		}

		sql += " GROUP BY GUEST_GENDER ORDER BY GUEST_GENDER";
		JSONArray jsonArray = new JSONArray();

		JSONArray colNameArray = new JSONArray();
		colNameArray.put("Gender");
		colNameArray.put("성별 인원수");
		jsonArray.put(colNameArray);

		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {

				do {
					JSONArray rowArray = new JSONArray();
					if (rs.getString("GUEST_GENDER").equals("0")) {
						rowArray.put("남자");
					} else {
						rowArray.put("여자");
					}
					rowArray.put(rs.getInt("count"));
					jsonArray.put(rowArray);
				} while (rs.next());
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return jsonArray;
	}

	@Override
	public JSONArray guestByOut(String year) {
		String sql = null;
		if (year.equals("all")) {
			sql = "SELECT DEL_YN ,COUNT(*)AS count FROM ";
		} else {
			sql = "SELECT DEL_YN ,COUNT(*)AS count FROM ";
			if (year != null) {
				sql += " WHERE TO_CHAR(GUEST_JOIN_DATE,'yyyy') = " + year + " ";
			}
		}

		sql += " GUEST GROUP BY DEL_YN ORDER BY DEL_YN";
		JSONArray jsonArray = new JSONArray();

		JSONArray colNameArray = new JSONArray();
		colNameArray.put("Delete");
		colNameArray.put("탈퇴");
		jsonArray.put(colNameArray);

		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {

				do {
					JSONArray rowArray = new JSONArray();
					rowArray.put(rs.getString("DEL_YN"));
					rowArray.put(rs.getInt("count"));
					jsonArray.put(rowArray);
				} while (rs.next());
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return jsonArray;
	}

	@Override
	public JSONArray bookingByTime() {
		String sql = "SELECT TO_CHAR(book_time,'yyyy-mm-dd:HH24')AS day ,COUNT(*)AS count FROM  BOOKING GROUP BY TO_CHAR(book_time,'yyyy-mm-dd:HH24') ORDER BY TO_CHAR(book_time,'yyyy-mm-dd:HH24')";

		JSONArray jsonArray = new JSONArray();

		JSONArray colNameArray = new JSONArray();
		colNameArray.put("Time");
		colNameArray.put("예약 수");
		jsonArray.put(colNameArray);

		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {

				do {
					JSONArray rowArray = new JSONArray();
					rowArray.put(rs.getString("day"));
					rowArray.put(rs.getInt("count"));
					jsonArray.put(rowArray);
				} while (rs.next());
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return jsonArray;
	}

	@Override
	public JSONArray bookingByDay() {
		String sql = "SELECT TO_CHAR(book_time,'yyyy-mm-dd:HH24')AS day ,COUNT(*)AS count FROM  BOOKING GROUP BY TO_CHAR(book_time,'yyyy-mm-dd:HH24') ORDER BY TO_CHAR(book_time,'yyyy-mm-dd:HH24')";

		JSONArray jsonArray = new JSONArray();

		JSONArray colNameArray = new JSONArray();
		colNameArray.put("Day");
		colNameArray.put("예약 수");
		jsonArray.put(colNameArray);

		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {

				do {
					JSONArray rowArray = new JSONArray();
					rowArray.put(rs.getString("day"));
					rowArray.put(rs.getInt("count"));
					jsonArray.put(rowArray);
				} while (rs.next());
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return jsonArray;
	}

	@Override
	public JSONArray bookginByDe() {
		String sql = "SELECT de_no ,COUNT(*)AS count FROM  BOOKING GROUP BY de_no ORDER BY de_no";

		JSONArray jsonArray = new JSONArray();

		JSONArray colNameArray = new JSONArray();
		colNameArray.put("Designer");
		colNameArray.put("예약 수");
		jsonArray.put(colNameArray);

		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {

				do {
					JSONArray rowArray = new JSONArray();
					rowArray.put(rs.getString("de_no"));
					rowArray.put(rs.getInt("count"));
					jsonArray.put(rowArray);
				} while (rs.next());
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return jsonArray;
	}

	@Override
	public JSONArray bookingByHair() {
		String sql = "SELECT hair_no ,COUNT(*)AS count FROM  BOOKING GROUP BY hair_no ORDER BY hair_no";

		JSONArray jsonArray = new JSONArray();

		JSONArray colNameArray = new JSONArray();
		colNameArray.put("Hair");
		colNameArray.put("예약 수");
		jsonArray.put(colNameArray);

		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {

				do {
					JSONArray rowArray = new JSONArray();
					rowArray.put(rs.getString("hair_no"));
					rowArray.put(rs.getInt("count"));
					jsonArray.put(rowArray);
				} while (rs.next());
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return jsonArray;
	}

	@Override
	public JSONArray ordersByDe() {
		String sql = "SELECT de_no ,COUNT(*)AS count FROM ORDERS GROUP BY de_no ORDER BY de_no";

		JSONArray jsonArray = new JSONArray();

		JSONArray colNameArray = new JSONArray();
		colNameArray.put("Designer");
		colNameArray.put("주문 수");
		jsonArray.put(colNameArray);

		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {

				do {
					JSONArray rowArray = new JSONArray();
					rowArray.put(rs.getString("de_no"));
					rowArray.put(rs.getInt("count"));
					jsonArray.put(rowArray);
				} while (rs.next());
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return jsonArray;
	}

	@Override
	public JSONArray ordersByDay() {
		String sql = "SELECT TO_CHAR(orders_date,'yyyy-mm-dd')AS day ,COUNT(*)AS count FROM ORDERS GROUP BY TO_CHAR(orders_date,'yyyy-mm-dd') ORDER BY TO_CHAR(orders_date,'yyyy-mm-dd')";

		JSONArray jsonArray = new JSONArray();

		JSONArray colNameArray = new JSONArray();
		colNameArray.put("Day");
		colNameArray.put("주문 수");
		jsonArray.put(colNameArray);

		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {

				do {
					JSONArray rowArray = new JSONArray();
					rowArray.put(rs.getString("day"));
					rowArray.put(rs.getInt("count"));
					jsonArray.put(rowArray);
				} while (rs.next());
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return jsonArray;
	}

	@Override
	public JSONArray orderDetailByevent() {
		String sql = "SELECT event_no ,COUNT(*)AS count FROM ORDER_DETAIL GROUP BY event_no ORDER BY event_no";

		JSONArray jsonArray = new JSONArray();

		JSONArray colNameArray = new JSONArray();
		colNameArray.put("Event");
		colNameArray.put("주문상세 수");
		jsonArray.put(colNameArray);

		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {

				do {
					JSONArray rowArray = new JSONArray();
					rowArray.put(rs.getString("event_no"));
					rowArray.put(rs.getInt("count"));
					jsonArray.put(rowArray);
				} while (rs.next());
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return jsonArray;
	}

	@Override
	public JSONArray orderDetailByHair() {
		String sql = "SELECT hair_no ,COUNT(*)AS count FROM ORDER_DETAIL GROUP BY hair_no ORDER BY hair_no";

		JSONArray jsonArray = new JSONArray();

		JSONArray colNameArray = new JSONArray();
		colNameArray.put("Hair");
		colNameArray.put("주문상세 수");
		jsonArray.put(colNameArray);

		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {

				do {
					JSONArray rowArray = new JSONArray();
					rowArray.put(rs.getString("hair_no"));
					rowArray.put(rs.getInt("count"));
					jsonArray.put(rowArray);
				} while (rs.next());
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return jsonArray;
	}

	@Override
	public JSONArray DesignerBylevel() {
		String sql = "SELECT de_level ,COUNT(*)AS count FROM DESIGNER GROUP BY de_level ORDER BY de_level";

		JSONArray jsonArray = new JSONArray();

		JSONArray colNameArray = new JSONArray();
		colNameArray.put("Level");
		colNameArray.put("디자이너 수");
		jsonArray.put(colNameArray);

		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {

				do {
					JSONArray rowArray = new JSONArray();
					rowArray.put(rs.getString("de_level"));
					rowArray.put(rs.getInt("count"));
					jsonArray.put(rowArray);
				} while (rs.next());
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return jsonArray;
	}
}
