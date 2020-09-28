package hairrang_web.ds;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class JdbcUtil {
	public static Connection getConnection() {
		
		Connection con = null;
		String proptiesPath = "Db.properties";
		
		try (InputStream is = ClassLoader.getSystemResourceAsStream(proptiesPath)) {
			
			Properties props = new Properties();
			props.load(is);
			
			String url = props.getProperty("url");
			con = DriverManager.getConnection(url, props);
			
		} catch (IOException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return con;
	}
	
	// <DB ?—°ê²? ?•´? œ 1> ë©”ì†Œ?“œ : ps + conn
		public static void dbClose(PreparedStatement ps, Connection conn) throws SQLException {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
			System.out.println("??›ë°˜ë‚©, DB Close!!");
		}

		// <DB ?—°ê²? ?•´? œ 2> ë©”ì†Œ?“œ : st + conn
		public static void dbClose(Statement st, Connection conn) throws SQLException {
			if (st != null)
				st.close();
			if (conn != null)
				conn.close();
			System.out.println("??›ë°˜ë‚©, DB Close!!");
		}

		// <DB ?—°ê²? ?•´? œ 3> ë©”ì†Œ?“œ : rs + ps + conn
		public static void dbClose(ResultSet rs, PreparedStatement ps, Connection conn) throws SQLException {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
			System.out.println("??›ë°˜ë‚©, DB Close!!");
		}

		// <DB ?—°ê²? ?•´? œ 4> ë©”ì†Œ?“œ : rs + st + conn
		public static void dbClose(ResultSet rs, Statement st, Connection conn) throws SQLException {
			if (rs != null)
				rs.close();
			if (st != null)
				st.close();
			if (conn != null)
				conn.close();
			System.out.println("??›ë°˜ë‚©, DB Close!!");
		}
}