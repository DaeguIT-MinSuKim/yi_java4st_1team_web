package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.swing.JButton;

import hairrang_web.dao.HboardDao;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Booking;
import hairrang_web.dto.HBoard;
import hairrang_web.dto.HBoardCate;

public class HBoardDaoImpl implements HboardDao{
	private static final HBoardDaoImpl instance = new HBoardDaoImpl();

	private HBoardDaoImpl() {}
	
	public static HBoardDaoImpl getInstance() {
		return instance;
	}

	@Override
	public ArrayList<HBoard> selectHboardByAll() {
		String sql = "SELECT HBOARD_NO,HBOARD_CATENO,HB_CATENAME,HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE FROM hb_view ORDER BY hboard_no";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if(rs.next()) {
				ArrayList<HBoard> list = new ArrayList<>();
				do {
					list.add(getHboard(rs));
				} while(rs.next());
				return list;
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	
	}


	public HBoardCate getHboardCate(ResultSet rs) throws SQLException {
		HBoardCate hCate = new HBoardCate();
		hCate.setHbCateNo(rs.getInt("HBOARD_CATENO"));
		hCate.setHbCateName(rs.getString("HBOARD_TITLE"));
		return hCate;
	}
	
	private HBoard getHboard(ResultSet rs) throws SQLException {
		//HBOARD_NO,HBOARD_CATENO,HB_CATENAME,HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE
		
		HBoard hb = new HBoard();
		HBoardCate hbCate = new HBoardCate();
		
		hb.setHbNo(rs.getInt("HBOARD_NO"));	
		hbCate.setHbCateNo(rs.getInt("HBOARD_CATENO"));
		hbCate.setHbCateName(rs.getString("HB_CATENAME"));
		hb.setHbTitle(rs.getString("HBOARD_TITLE"));
		hb.setHbContent(rs.getString("HBOARD_CONTENT"));
		hb.setHbPic(rs.getString("HBOARD_PIC"));
		hb.setHbRegDate(rs.getTimestamp("HBOARD_REGDATE").toLocalDateTime());
		
		return hb;
	}
	
	@Override
	public HBoardCate selectHBoardByCateNo(int no){
		String sql = "SELECT HBOARD_NO,HBOARD_CATENO,HB_CATENAME,HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE "
				+ "FROM hb_view WHERE hboard_cateno = ? ORDER BY hboard_no";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setInt(1, no);
				try(ResultSet rs = pstmt.executeQuery()){
					if(rs.next()) {
						HBoard hb = new HBoard();
						HBoardCate hbCate = new HBoardCate();

						hb.setHbNo(rs.getInt("HBOARD_NO"));	
						hbCate.setHbCateNo(rs.getInt("HBOARD_CATENO"));
						hbCate.setHbCateName(rs.getString("HB_CATENAME"));
						hb.setHbTitle(rs.getString("HBOARD_TITLE"));
						hb.setHbContent(rs.getString("HBOARD_CONTENT"));
						hb.setHbPic(rs.getString("HBOARD_PIC"));
						hb.setHbRegDate(rs.getTimestamp("HBOARD_REGDATE").toLocalDateTime());
						
						ArrayList<HBoard> list = new ArrayList<HBoard>();
						hbCate.sethBoard(list);
						do {
							list.add(getHboard(rs));
						}while(rs.next());
						return hbCate;
					}
				}
		} catch (SQLException e) {
			throw new RuntimeException();
		}
		return null;
	}
	
	
	@Override
	public ArrayList<Integer> cateNoList() {
		String sql = "SELECT DISTINCT(hboard_cateno) FROM hb_view ORDER BY hboard_cateno";
		try (Connection con = JndiDs.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					ArrayList<Integer> list = new ArrayList<>();
					do {
						list.add(rs.getInt(1));
					} while (rs.next());
					return list;
				}
	} catch (SQLException e) {
		throw new RuntimeException();
	}
		return null;
	}
	
	
	
	
}
