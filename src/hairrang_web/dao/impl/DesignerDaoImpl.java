package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import hairrang_web.dao.DesignerDao;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Designer;

/**
 * 
 * @author jisu25
 */
public class DesignerDaoImpl implements DesignerDao {

	private static final DesignerDaoImpl instance = new DesignerDaoImpl();
	
	private DesignerDaoImpl() {
	}

	public static DesignerDaoImpl getInstance() {
		return instance;
	}

	@Override
	public ArrayList<Designer> selectDesignerAll() {
		String sql = "SELECT * FROM DESIGNER";
		
		try(Connection con = JndiDs.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery()) {

			if(rs.next()) {
				ArrayList<Designer> list = new ArrayList<>();
				do {
					list.add(getDesigner(rs));
				} while(rs.next());
				return list;
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		
		return null;
	}

	private Designer getDesigner(ResultSet rs) throws SQLException {
		int deNo = rs.getInt("DE_NO");
		String deName = rs.getString("DE_NAME");
		String deNickname = rs.getString("DE_NICKNAME");
		String deLevel = rs.getString("DE_LEVEL");
		String dePic = null;
		try {
			dePic = rs.getString("DE_PIC");
		} catch(SQLException e) {
		}
		String deContent = null;
		try {
			deContent = rs.getString("DE_CONTENT");
		} catch(SQLException e) {
		}
		
		return new Designer(deNo, deName, deNickname, deLevel, dePic, deContent);
	}

	@Override
	public Designer selectDesignerByNo(Designer de) {
		String sql = "SELECT * FROM DESIGNER WHERE DE_NO = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, de.getDeNo());
			
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next())
					return getDesigner(rs);
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public int insertDesigner(Designer de) {
		String sql = "INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES(?, ?, ?, ?, ?)";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
				
			pstmt.setString(1, de.getDeName());
			pstmt.setString(2, de.getDeNickname());
			pstmt.setString(3, de.getDeLevel());
			pstmt.setString(4, de.getDePic());
			pstmt.setString(5, de.getDeContent());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int updateDesigner(Designer de) {
		String sql = "INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES(?, ?, ?, ?, ?)";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
				
			pstmt.setString(1, de.getDeName());
			pstmt.setString(2, de.getDeNickname());
			pstmt.setString(3, de.getDeLevel());
			pstmt.setString(4, de.getDePic());
			pstmt.setString(5, de.getDeContent());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int deleteDesigner(Designer de) {
		String sql = "UPDATE DESIGNER SET DE_NAME = ?, DE_NICKNAME = ?, DE_LEVEL = ?, DE_PIC = ?, "
				+ "DE_CONTENT = ? WHERE DE_NO = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
				
			pstmt.setString(1, de.getDeName());
			pstmt.setString(2, de.getDeNickname());
			pstmt.setString(3, de.getDeLevel());
			pstmt.setString(4, de.getDePic());
			pstmt.setString(5, de.getDeContent());
			pstmt.setInt(6, de.getDeNo());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	

}
