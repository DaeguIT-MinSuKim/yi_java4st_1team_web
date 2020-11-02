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
	public JSONArray selectOnlyQnA() {
		String sql = "SELECT TO_CHAR(QNA_REGDATE,'yyyy-mm-dd')AS day ,COUNT(*)AS count FROM qna WHERE ADMIN_ID IS NULL GROUP BY TO_CHAR(QNA_REGDATE,'yyyy-mm-dd') ORDER BY TO_CHAR(QNA_REGDATE,'yyyy-mm-dd')";

		JSONArray jsonArray = new JSONArray();

		JSONArray colNameArray = new JSONArray();
		colNameArray.put("Day");
		colNameArray.put("문의 갯수");
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

}
