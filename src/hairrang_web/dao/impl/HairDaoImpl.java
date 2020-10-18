package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import hairrang_web.dao.HairDao;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Hair;
import hairrang_web.dto.HairKind;

public class HairDaoImpl implements HairDao {

	private static final HairDaoImpl instance = new HairDaoImpl();
	
	private HairDaoImpl() {
	}
	
	public static HairDaoImpl getInstance() {
		return instance;
	}


	@Override
	public ArrayList<HairKind> selectHairAll() {
		String sql = "SELECT * FROM HAIR_KIND ORDER BY KIND_NO";
		
		try(Connection con = JndiDs.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery()) {
			
			if(rs.next()) {
				ArrayList<HairKind> list = new ArrayList<>();
				do {
					HairKind hairKind = selectHairKindByKindNo(rs.getInt("KIND_NO"));
					hairKind.setKindName(rs.getString("KIND_NAME"));
					list.add(hairKind);
				} while(rs.next());
				return list;
			}
			
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public HairKind selectHairKindByKindNo(int kindNo) {
		String sql = "SELECT * FROM HAIR_VIEW WHERE KIND_NO = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, kindNo);
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					HairKind hairKind = new HairKind(kindNo);
					ArrayList<Hair> list = new ArrayList<>();
					while(rs.next()) {
						list.add(getHair(rs));
					}
					hairKind.setHairList(list);
					return hairKind;
				}
			}
		} catch(SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}
	
	private Hair getHair(ResultSet rs) throws SQLException {
		int hairNo = rs.getInt("HAIR_NO");
		String hairName = rs.getString("HAIR_NAME");
		int hairPrice = rs.getInt("HAIR_PRICE");
		String hairPic = rs.getString("HAIR_PIC");
		String hairContent = rs.getString("HAIR_CONTENT");
		int kindNo = rs.getInt("KIND_NO");
		
		return new Hair(hairNo, hairName, hairPrice, hairPic, hairContent, kindNo);
	}

	@Override
	public Hair selectHairByNo(Hair hair) {
		String sql = "SELECT * FROM HAIR_VIEW WHERE HAIR_NO = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, hair.getHairNo());
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					return getHair(rs);
				}
			}
		} catch(SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public int insertHair(Hair hair) {
		String sql = "INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES(?, ?, ?, ?, ?)";
		
		try(Connection con = JndiDs.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, hair.getHairName());
			pstmt.setInt(2, hair.getHairPrice());
			pstmt.setString(3, hair.getHairPic());
			pstmt.setString(4, hair.getHairContent());
			pstmt.setInt(5, hair.getKindNo());

			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int updateHair(Hair hair) {
		String sql = "UPDATE HAIR HAIR_NAME = ?, HAIR_PRICE = ?, HAIR_PIC = ?, HAIR_CONTENT = ?, KIND_NO = ? WHERE HAIR_NO = ?";
		
		try(Connection con = JndiDs.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, hair.getHairName());
			pstmt.setInt(2, hair.getHairPrice());
			pstmt.setString(3, hair.getHairPic());
			pstmt.setString(4, hair.getHairContent());
			pstmt.setInt(5, hair.getKindNo());
			pstmt.setInt(6, hair.getHairNo());

			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int deleteHair(Hair hair) {
		String sql = "DELETE HAIR WHERE HAIR_NO = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, hair.getHairNo());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	
	
	/* 헤어 종류 CRUD */
	
	@Override
	public int insertHairKind(HairKind kind) {
		String sql = "INSERT INTO HAIR_KIND(KIND_NAME) VALUES(?)";
		
		try(Connection con = JndiDs.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, kind.getKindName());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int updateHairKind(HairKind kind) {
		String sql = "UPDATE HAIR_KIND SET KIND_NAME = ? WHERE KIND_NO = ?";
		
		try(Connection con = JndiDs.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, kind.getKindName());
			pstmt.setInt(2, kind.getKindNo());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int deleteHairKind(HairKind kind) {
		String sql = "DELETE HAIR_KIND WHERE KIND_NO = ?";
		
		try(Connection con = JndiDs.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, kind.getKindNo());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	

}
