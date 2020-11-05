package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;

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
	public JSONArray qnaByoneDay(String year, String month) {
	String sql = null;
		
		if(month != null) {
			//년도별 sql
			Calendar cal = Calendar.getInstance();
			cal.set(Integer.parseInt(year),Integer.parseInt(month)-1, 1);
			int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			System.out.println("달==>"+month);
			System.out.println("마지막일==>"+lastDay);
			
			 sql = "SELECT TO_CHAR(b.dt, 'DD') AS QNA_REGDATE\r\n" + 
			 		"     , NVL(SUM(a.cnt), 0) cnt\r\n" + 
			 		"  FROM ( SELECT TO_CHAR(QNA_REGDATE, 'YYYY-MM-DD') AS QNA_REGDATE\r\n" + 
			 		"              , COUNT(*) cnt\r\n" + 
			 		"           FROM qna\r\n" + 
			 		"          WHERE QNA_REGDATE BETWEEN TO_DATE('"+ year +"-"+ month +"-01', 'YYYY-MM-DD')\r\n" + 
			 		"                             AND TO_DATE('"+ year +"-"+ month +"-"+ lastDay +"' , 'YYYY-MM-DD') \r\n" + 
			 		"          GROUP BY QNA_REGDATE\r\n" + 
			 		"        ) a\r\n" + 
			 		"      , ( SELECT TO_DATE('"+ year +"-"+ month +"-01','YYYY-MM-DD') + LEVEL - 1 AS dt\r\n" + 
			 		"            FROM dual \r\n" + 
			 		"         CONNECT BY LEVEL <= (TO_DATE('"+ year +"-"+ month +"-"+ lastDay +"','YYYY-MM-DD') \r\n" + 
			 		"                            - TO_DATE('"+ year +"-"+ month +"-01','YYYY-MM-DD') + 1)\r\n" + 
			 		"        ) b\r\n" + 
			 		"  WHERE b.dt = a.QNA_REGDATE(+)\r\n" + 
			 		"  GROUP BY TO_CHAR(b.dt, 'DD')\r\n" + 
			 		"  ORDER BY TO_CHAR(b.dt, 'DD')";
		}else {
			//년도별 sql
			Calendar cal = Calendar.getInstance();
			cal.set(Integer.parseInt(year),12-1, 1);
			int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			
			 sql = "SELECT TO_CHAR(b.dt, 'YYYY-MM') AS QNA_REGDATE\r\n" + 
			 		"     , NVL(SUM(a.cnt), 0) cnt\r\n" + 
			 		"  FROM ( SELECT TO_CHAR(QNA_REGDATE, 'YYYY-MM-DD') AS QNA_REGDATE\r\n" + 
			 		"              , COUNT(*) cnt\r\n" + 
			 		"           FROM qna\r\n" + 
			 		"          WHERE QNA_REGDATE BETWEEN TO_DATE('"+ year +"-1-01', 'YYYY-MM-DD')\r\n" + 
			 		"                             AND TO_DATE('"+ year +"-12-"+ lastDay +"' , 'YYYY-MM-DD') \r\n" + 
			 		"          GROUP BY QNA_REGDATE\r\n" + 
			 		"        ) a\r\n" + 
			 		"      , ( SELECT TO_DATE('"+ year +"-1-01','YYYY-MM-DD') + LEVEL - 1 AS dt\r\n" + 
			 		"            FROM dual \r\n" + 
			 		"         CONNECT BY LEVEL <= (TO_DATE('"+ year +"-12-"+ lastDay +"','YYYY-MM-DD') \r\n" + 
			 		"                            - TO_DATE('"+ year +"-1-01','YYYY-MM-DD') + 1)\r\n" + 
			 		"        ) b\r\n" + 
			 		"  WHERE b.dt = a.QNA_REGDATE(+)\r\n" + 
			 		"  GROUP BY TO_CHAR(b.dt, 'YYYY-MM')\r\n" + 
			 		"  ORDER BY TO_CHAR(b.dt, 'YYYY-MM')";
		}
		
		System.out.println("완성된 sql ==>"+sql);
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
					rowArray.put(rs.getString("QNA_REGDATE"));
					rowArray.put(rs.getInt("cnt"));
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
	public JSONArray guestByJoin(String startDate, String endDate) {
		String sql = "SELECT TO_CHAR(b.dt, 'DD') AS QNA_REGDATE\r\n" + 
				"     , NVL(SUM(a.cnt), 0) cnt\r\n" + 
				"  FROM ( SELECT TO_CHAR(QNA_REGDATE, 'YYYY-MM-DD') AS QNA_REGDATE\r\n" + 
				"              , COUNT(*) cnt\r\n" + 
				"           FROM qna\r\n" + 
				"          WHERE QNA_REGDATE BETWEEN TO_DATE('"+ startDate +"', 'YYYY-MM-DD')\r\n" + 
				"                             AND TO_DATE('"+ endDate +"' , 'YYYY-MM-DD') \r\n" + 
				"          GROUP BY QNA_REGDATE\r\n" + 
				"        ) a\r\n" + 
				"      , ( SELECT TO_DATE('"+ startDate +"','YYYY-MM-DD') + LEVEL - 1 AS dt\r\n" + 
				"            FROM dual \r\n" + 
				"         CONNECT BY LEVEL <= (TO_DATE('"+ endDate +"','YYYY-MM-DD') \r\n" + 
				"                            - TO_DATE('"+ startDate +"','YYYY-MM-DD') + 1)\r\n" + 
				"        ) b\r\n" + 
				"  WHERE b.dt = a.QNA_REGDATE(+)\r\n" + 
				"  GROUP BY b.dt\r\n" + 
				"  ORDER BY b.dt";
		
		
		
		/*if (year.equals("all")) {
			sql = "SELECT TO_CHAR(GUEST_JOIN_DATE,'yyyy')AS day ,COUNT(*)AS count FROM GUEST  GROUP BY TO_CHAR(GUEST_JOIN_DATE,'yyyy') ORDER BY TO_CHAR(GUEST_JOIN_DATE,'yyyy')";
		} else {
			sql = "SELECT TO_CHAR(GUEST_JOIN_DATE,'mm')AS day ,COUNT(*)AS count FROM GUEST ";
			if (year != null) {
				sql += " WHERE TO_CHAR(GUEST_JOIN_DATE,'yyyy') = " + year + " GROUP BY TO_CHAR(GUEST_JOIN_DATE,'mm') ORDER BY TO_CHAR(GUEST_JOIN_DATE,'mm')";
			}
		}*/
		
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
					rowArray.put(rs.getString("QNA_REGDATE"));
					rowArray.put(rs.getInt("cnt"));
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
			sql = "SELECT GUEST_GENDER ,COUNT(*)AS count FROM GUEST_VIEW";
		} else {
			sql = "SELECT GUEST_GENDER ,COUNT(*)AS count FROM ";
			if (year != null) {
				sql += "(SELECT * FROM GUEST_VIEW WHERE TO_CHAR(GUEST_JOIN_DATE,'yyyy') = " + year + " AND DEL_YN = 'n') ";
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
	public JSONArray guestIncrease(String year, String month) {
		String sql = null;
		
		if(month != null) {
			//년도별 sql
			Calendar cal = Calendar.getInstance();
			cal.set(Integer.parseInt(year),Integer.parseInt(month)-1, 1);
			int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			System.out.println("달==>"+month);
			System.out.println("마지막일==>"+lastDay);
			
			 sql = "SELECT TO_CHAR(b.dt, 'dd') AS GUEST_JOIN_DATE \r\n" + 
			 		"     , NVL(SUM(a.cnt), 0)AS CNT \r\n" + 
			 		"  FROM ( SELECT TO_CHAR(GUEST_JOIN_DATE, 'YYYY-MM-DD') AS GUEST_JOIN_DATE\r\n" + 
			 		"              , COUNT(*)AS cnt \r\n" + 
			 		"           FROM GUEST\r\n" + 
			 		"          WHERE DEL_YN ='n' AND GUEST_JOIN_DATE BETWEEN TO_DATE('"+ year +"-"+ month +"-01', 'YYYY-MM-DD')\r\n" + 
			 		"                             AND TO_DATE('"+ year +"-"+ month +"-"+ lastDay +"' , 'YYYY-MM-DD') \r\n" + 
			 		"          GROUP BY GUEST_JOIN_DATE \r\n" + 
			 		"        ) a\r\n" + 
			 		"      , ( SELECT TO_DATE('"+ year +"-"+ month +"-01','YYYY-MM-DD') + LEVEL - 1 AS dt\r\n" + 
			 		"            FROM dual \r\n" + 
			 		"         CONNECT BY LEVEL <= (TO_DATE('"+ year +"-"+ month +"-"+ lastDay +"','YYYY-MM-DD') \r\n" + 
			 		"                            - TO_DATE('"+ year +"-"+ month +"-01','YYYY-MM-DD') + 1)\r\n" + 
			 		"        ) b\r\n" + 
			 		"  WHERE b.dt = a.GUEST_JOIN_DATE(+)\r\n" + 
			 		"  GROUP BY TO_CHAR(b.dt, 'dd')\r\n" + 
			 		"  ORDER BY TO_CHAR(b.dt, 'dd')";
		}else {
			//년도별 sql
			Calendar cal = Calendar.getInstance();
			cal.set(Integer.parseInt(year),12-1, 1);
			int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			
			 sql = "SELECT TO_CHAR(b.dt, 'YYYY-MM') AS GUEST_JOIN_DATE \r\n" + 
					"     , NVL(SUM(a.cnt), 0)AS CNT \r\n" + 
					"  FROM ( SELECT TO_CHAR(GUEST_JOIN_DATE, 'YYYY-MM-DD') AS GUEST_JOIN_DATE\r\n" + 
					"              , COUNT(*)AS cnt \r\n" + 
					"           FROM GUEST\r\n" + 
					"          WHERE DEL_YN ='n' AND GUEST_JOIN_DATE BETWEEN TO_DATE('"+ year +"-01-01', 'YYYY-MM-DD')\r\n" + 
					"                             AND TO_DATE('"+ year +"-12-"+ lastDay +"' , 'YYYY-MM-DD') \r\n" + 
					"          GROUP BY GUEST_JOIN_DATE \r\n" + 
					"        ) a\r\n" + 
					"      , ( SELECT TO_DATE('"+ year +"-01-01','YYYY-MM-DD') + LEVEL - 1 AS dt\r\n" + 
					"            FROM dual \r\n" + 
					"         CONNECT BY LEVEL <= (TO_DATE('"+ year +"-12-"+ lastDay +"','YYYY-MM-DD') \r\n" + 
					"                            - TO_DATE('"+ year +"-01-01','YYYY-MM-DD') + 1)\r\n" + 
					"        ) b\r\n" + 
					"  WHERE b.dt = a.GUEST_JOIN_DATE(+)\r\n" + 
					"  GROUP BY TO_CHAR(b.dt, 'YYYY-MM')\r\n" + 
					"  ORDER BY TO_CHAR(b.dt, 'YYYY-MM')";
		}
		
		System.out.println("완성된 sql ==>"+sql);
		
		JSONArray jsonArray = new JSONArray();

		JSONArray colNameArray = new JSONArray();
		colNameArray.put("Increase");
		colNameArray.put("증가 회원");
		jsonArray.put(colNameArray);

		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {

				do {
					JSONArray rowArray = new JSONArray();
					rowArray.put(rs.getString("GUEST_JOIN_DATE"));
					rowArray.put(rs.getInt("CNT"));
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
	public JSONArray ordersByDay(String year, String month) {
String sql = null;
		
		if(month != null) {
			//년도별 sql
			Calendar cal = Calendar.getInstance();
			cal.set(Integer.parseInt(year),Integer.parseInt(month)-1, 1);
			int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			System.out.println("달==>"+month);
			System.out.println("마지막일==>"+lastDay);
			
			 sql = "SELECT TO_CHAR(b.dt, 'dd ') AS ORDERS_DATE\r\n" + 
			 		"    , NVL(SUM(a.cnt), 0) cnt\r\n" + 
			 		"  FROM ( SELECT TO_CHAR(ORDERS_DATE , 'yyyy-MM-dd ') AS ORDERS_DATE\r\n" + 
			 		"              , COUNT(*) cnt\r\n" + 
			 		"           FROM ORDERS\r\n" + 
			 		"          WHERE ORDERS_DATE BETWEEN TO_DATE('"+ year +"-"+ month +"-01', 'yyyy-MM-dd ')\r\n" + 
			 		"                             AND TO_DATE('"+ year +"-"+ month +"-"+ lastDay +"' , 'yyyy-MM-dd ') \r\n" + 
			 		"          GROUP BY ORDERS_DATE\r\n" + 
			 		"        ) a\r\n" + 
			 		"      , ( SELECT TO_DATE('"+ year +"-"+ month +"-01 ','yyyy-MM-dd ') + LEVEL - 1 AS dt\r\n" + 
			 		"            FROM dual \r\n" + 
			 		"         CONNECT BY LEVEL <= (TO_DATE('"+ year +"-"+ month +"-"+ lastDay +" ','yyyy-MM-dd ') \r\n" + 
			 		"                            - TO_DATE('"+ year +"-"+ month +"-01 ','yyyy-MM-dd ') + 1)\r\n" + 
			 		"        ) b\r\n" + 
			 		"  WHERE b.dt = a.ORDERS_DATE(+)\r\n" + 
			 		"  GROUP BY TO_CHAR(b.dt, 'dd ') \r\n" + 
			 		"  ORDER BY TO_CHAR(b.dt, 'dd ')";
		}else {
			//년도별 sql
			Calendar cal = Calendar.getInstance();
			cal.set(Integer.parseInt(year),12-1, 1);
			int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			
			 sql = "SELECT TO_CHAR(b.dt, 'yyyy-MM ') AS ORDERS_DATE\r\n" + 
			 		"    , NVL(SUM(a.cnt), 0) cnt\r\n" + 
			 		"  FROM ( SELECT TO_CHAR(ORDERS_DATE , 'yyyy-MM-dd ') AS ORDERS_DATE\r\n" + 
			 		"              , COUNT(*) cnt\r\n" + 
			 		"           FROM ORDERS\r\n" + 
			 		"          WHERE ORDERS_DATE BETWEEN TO_DATE('"+ year +"-11-01', 'yyyy-MM-dd ')\r\n" + 
			 		"                             AND TO_DATE('"+ year +"-12-"+ lastDay +"' , 'yyyy-MM-dd ') \r\n" + 
			 		"          GROUP BY ORDERS_DATE\r\n" + 
			 		"        ) a\r\n" + 
			 		"      , ( SELECT TO_DATE('"+ year +"-1-01 ','yyyy-MM-dd ') + LEVEL - 1 AS dt\r\n" + 
			 		"            FROM dual \r\n" + 
			 		"         CONNECT BY LEVEL <= (TO_DATE('"+ year +"-12-"+ lastDay +" ','yyyy-MM-dd ') \r\n" + 
			 		"                            - TO_DATE('"+ year +"-1-01 ','yyyy-MM-dd ') + 1)\r\n" + 
			 		"        ) b\r\n" + 
			 		"  WHERE b.dt = a.ORDERS_DATE(+)\r\n" + 
			 		"  GROUP BY TO_CHAR(b.dt, 'yyyy-MM ')\r\n" + 
			 		"  ORDER BY TO_CHAR(b.dt, 'yyyy-MM ')";
		}
		
		System.out.println("완성된 sql ==>"+sql);
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
					rowArray.put(rs.getString("ORDERS_DATE"));
					rowArray.put(rs.getInt("cnt"));
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
