package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import hairrang_web.dao.CouponDao;
import hairrang_web.dao.EventDao;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Coupon;
import hairrang_web.dto.Event;
import hairrang_web.dto.Guest;
import hairrang_web.utils.Paging;

public class CouponDaoImpl implements CouponDao{
	private static final CouponDaoImpl instance = new CouponDaoImpl();

	public CouponDaoImpl() {}
	
	public static CouponDaoImpl getInstance() {
		return instance;
	}

	private Coupon getCoupon(ResultSet rs) throws SQLException {
		//COUPON_ID,GUEST_ID,EVENT_NO,EVENT_START,EVENT_END,USED_YN
		EventDao eDao = EventDaoImpl.getInstance();
		
		Coupon coupon = new Coupon();
		Guest guest = new Guest();
		Event event = eDao.selectEventByNo(new Event(rs.getInt("EVENT_NO")));
		coupon.setGuest(guest);
		coupon.setEvent(event);
		
		coupon.setCouponId(rs.getInt("COUPON_ID"));
		guest.setGuestId(rs.getString("GUEST_ID"));
		event.setEventNo(rs.getInt("EVENT_NO"));
		event.setEventStart(rs.getTimestamp("EVENT_START").toLocalDateTime().toLocalDate());
		event.setEventEnd(rs.getTimestamp("EVENT_END").toLocalDateTime().toLocalDate());
		coupon.setUsedYn(rs.getString("USED_YN"));
		
		return coupon;
	}
	
	@Override
	public ArrayList<Coupon> selectCouponById(String id) {
		String sql = "SELECT COUPON_ID,GUEST_ID,EVENT_NO,EVENT_START,EVENT_END,USED_YN FROM coupon WHERE GUEST_ID = ?";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, id);
				try(ResultSet rs = pstmt.executeQuery()){
					if(rs.next()) {
						ArrayList<Coupon> list = new ArrayList<Coupon>();
						do {
							list.add(getCoupon(rs));
						}while(rs.next());
						return list;
					}
				}
			}catch(SQLException e) {
				throw new RuntimeException();
			}
		return null;
	}

	
//////////////////////////////////////페이징/////////////////////////////////////////////////
	
	
	@Override
	public ArrayList<Coupon> pagingCouponById(Paging paging, String id) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM coupon WHERE GUEST_ID = ? ORDER BY COUPON_ID desc) a) "
				+ "WHERE rn BETWEEN ? AND ? ORDER BY rn";
		try (Connection con = JndiDs.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, id);
			pstmt.setInt(2, paging.getStart());
			pstmt.setInt(3, paging.getEnd());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					ArrayList<Coupon> list = new ArrayList<>();
					do {
						list.add(getCoupon(rs));
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
	public int countCouponById(String id) {
		String sql = "SELECT COUNT(*) FROM COUPON WHERE GUEST_ID = ?";
		try (Connection con = JndiDs.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, id);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return rs.getInt(1);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}

		return 0;

	}

	
	
}
