package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import hairrang_web.dao.AdminDao;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Admin;

public class AdminDaoImpl implements AdminDao {

	private static final AdminDaoImpl instance = new AdminDaoImpl();
	
	private AdminDaoImpl() {
	}
	
	public static AdminDaoImpl getInstance() {
		return instance;
	}

	@Override
	public ArrayList<Admin> selectAdminAll() {
		String sql = "SELECT * FROM ADMIN_ALL_VIEW";
		ArrayList<Admin> list = null;
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if(rs.next()) {
				list = new ArrayList<>();
				list.add(getAdmin(rs));
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return list;
	}

	private Admin getAdmin(ResultSet rs) throws SQLException {
		String adminId = rs.getString("ADMIN_ID");
		String adminPwd = null;
		try {
			adminPwd = rs.getString("ADMIN_PWD");
		} catch(SQLException e) {
		}
		String adminName = rs.getString("ADMIN_NAME");
		
		return new Admin(adminId, adminPwd, adminName);
	}

	
	@Override
	public Admin selectAdminById(Admin Admin) {
		String sql = "SELECT * FROM ADMIN_ALL_VIEW WHERE ADMIN_ID = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			try (ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					return getAdmin(rs);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		
		return null;
	}

	
	@Override
	public int insertAdmin(Admin admin) {
		String sql = "INSERT INTO ADMIN VALUES(?, ?, ?)";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, admin.getAdminId());
			pstmt.setString(2, admin.getAdminPwd());
			pstmt.setString(3, admin.getAdminName());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	
	@Override
	public int updateAdminName(Admin admin) {
		String sql = "UPDATE ADMIN SET ADMIN_NAME = ? WHERE ADMIN_ID = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, admin.getAdminName());
			pstmt.setString(2, admin.getAdminId());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	
	@Override
	public int updateAdminPwd(Admin admin) {
		String sql = "UPDATE ADMIN SET ADMIN_PWD = ? WHERE ADMIN_ID = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, admin.getAdminPwd());
			pstmt.setString(2, admin.getAdminId());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	@Override
	public int deleteAdmin(Admin admin) {
		String sql = "DELETE ADMIN WHERE ADMIN_ID = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(2, admin.getAdminId());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	
	@Override
	public int checkPwd(String id, String pwd) {
		String sql = "SELECT 1 FROM ADMIN WHERE ADMIN_ID = ?, ADMIN_PWD = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			try (ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					return rs.getInt(1); // 비밀번호 일치함
				}
				return 0; // 비밀번호 불일치, 혹은 아이디가 없을 수도. --> 경우를 따로 구분해줄 것인가?
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
}
