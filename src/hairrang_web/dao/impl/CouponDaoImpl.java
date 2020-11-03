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

	@Override
	public Coupon selectCouponByCouponId(Coupon coupon) {
		String sql = "SELECT * FROM COUPON_VIEW WHERE COUPON_ID = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, coupon.getCouponId());
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					return getCoupon(rs);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException();
		}
		return null;
	}
	
	private Coupon getCoupon(ResultSet rs) throws SQLException {
		//COUPON_ID,GUEST_ID,EVENT_NO,EVENT_START,EVENT_END,USED_YN
		//EventDao eDao = EventDaoImpl.getInstance();
		//COUPON_ID,GUEST_ID,EVENT_NO,EVENT_START,EVENT_END,USED_YN,EVENT_NAME,EVENT_SALERATE
		
		Coupon coupon = new Coupon();
		Guest guest = new Guest();
		Event event = new Event();
		//Event event = eDao.selectEventByNo(new Event(rs.getInt("EVENT_NO")));
		coupon.setGuest(guest);
		coupon.setEvent(event);
		
		coupon.setCouponId(rs.getInt("COUPON_ID"));
		guest.setGuestId(rs.getString("GUEST_ID"));
		event.setEventNo(rs.getInt("EVENT_NO"));
		event.setEventName(rs.getString("EVENT_NAME"));
		event.setEventSaleRate(rs.getDouble("EVENT_SALERATE"));
		event.setEventStart(rs.getTimestamp("EVENT_START").toLocalDateTime().toLocalDate());
		event.setEventEnd(rs.getTimestamp("EVENT_END").toLocalDateTime().toLocalDate());
		coupon.setUsedYn(rs.getString("USED_YN"));
		event.setEventStatus(rs.getString("EVENT_STATUS"));
		
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

	
	// 오늘자 사용가능한 쿠폰 보여주기
	@Override
	public ArrayList<Coupon> selectAvailableCouponToday(String id) {
		String sql = "SELECT * FROM coupon_view WHERE guest_id = ? AND USED_YN = 'n' AND SYSDATE BETWEEN EVENT_START AND EVENT_END";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, id);
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					ArrayList<Coupon> list = new ArrayList<Coupon>();
					do {
						list.add(getCoupon(rs));
					} while(rs.next());
					return list;
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException();
		}
		
		return null;
	}
	
//////////////////////////////////////페이징/////////////////////////////////////////////////
	
	@Override
	public ArrayList<Coupon> pagingCouponByAll(Paging paging) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM coupon_view ORDER BY COUPON_ID desc) a) WHERE rn BETWEEN ? AND ? ORDER BY rn";
		//"SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM GUEST ORDER BY GUEST_JOIN_DATE desc) a) "
		//"WHERE rn BETWEEN ? AND ? ORDER BY rn";
		try (Connection con = JndiDs.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, paging.getStart());
			pstmt.setInt(2, paging.getEnd());
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
	public int countCoupon() {
		String sql = "SELECT COUNT(*) FROM coupon";
		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return 0;
	}
	
	

	@Override
	public ArrayList<Coupon> pagingCouponByEventNo(Paging paging, int eventNo) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM coupon_view where event_no = ? ORDER BY COUPON_ID desc) a) WHERE rn BETWEEN ? AND ? ORDER BY rn";
		try (Connection con = JndiDs.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, eventNo);
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
	public int countCoupon(int eventNo) {
		String sql = "SELECT COUNT(*) FROM coupon where event_no = ?";
		try (Connection con = JndiDs.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql)) {
				pstmt.setInt(1, eventNo);
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
