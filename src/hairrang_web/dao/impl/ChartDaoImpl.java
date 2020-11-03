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
	public JSONArray QnAByoneDay() {
		String sql = "SELECT TO_CHAR(QNA_REGDATE,'yyyy-mm')AS day ,COUNT(*)AS count FROM qna WHERE ADMIN_ID IS NULL GROUP BY TO_CHAR(QNA_REGDATE,'yyyy-mm') ORDER BY TO_CHAR(QNA_REGDATE,'yyyy-mm')";

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
	public JSONArray joinGuestByOneDay() {
		String sql = "SELECT TO_CHAR(GUEST_JOIN_DATE,'yyyy-mm')AS day ,COUNT(*)AS count FROM  GUEST GROUP BY TO_CHAR(GUEST_JOIN_DATE,'yyyy-mm') ORDER BY TO_CHAR(GUEST_JOIN_DATE,'yyyy-mm')";

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
	public JSONArray gender() {
		String sql = "SELECT GUEST_GENDER ,COUNT(*)AS count FROM  GUEST GROUP BY GUEST_GENDER ORDER BY GUEST_GENDER";

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
					if(rs.getString("GUEST_GENDER").equals("0")){
						rowArray.put("남자");
					}else {
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

	@Override
	public JSONArray QnAByRes() {
		String sql = "SELECT RES_YN ,COUNT(*)AS count FROM qna GROUP BY RES_YN ORDER BY RES_YN";

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

}
