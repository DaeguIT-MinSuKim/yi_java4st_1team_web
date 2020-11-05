package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;

import hairrang_web.dao.DesignerDao;
import hairrang_web.dao.GuestDao;
import hairrang_web.dao.HairDao;
import hairrang_web.dao.OrdersDao;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Booking;
import hairrang_web.dto.BookingHairs;
import hairrang_web.dto.Coupon;
import hairrang_web.dto.Designer;
import hairrang_web.dto.Event;
import hairrang_web.dto.Guest;
import hairrang_web.dto.Hair;
import hairrang_web.dto.OrderDetail;
import hairrang_web.dto.Orders;
import hairrang_web.utils.Paging;

public class OrdersDaoImpl implements OrdersDao {

	public static final OrdersDaoImpl instance = new OrdersDaoImpl();
	
	private OrdersDaoImpl() {
	}
	
	public static OrdersDaoImpl getInstance() {
		return instance;
	}


	@Override
	public ArrayList<Orders> selectOrdersAll() {
		String sql = "SELECT * FROM ORDERS ORDER BY ORDERS_NO DESC";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if(rs.next()) {
				ArrayList<Orders> list = new ArrayList<Orders>();
				do {
					list.add(getOrders(rs));
				} while(rs.next());
				return list;
			}
		} catch (SQLException e) {
			throw new RuntimeException();
		}
		return null;
	}

	private Orders getOrders(ResultSet rs) throws SQLException {
		// orders_no, guest_id, de_no, orders_total_price, ORDERS_DATE
		Orders order = null;
		
		int ordersNo = rs.getInt("ORDERS_NO");
		Guest guest = GuestDaoImpl.getInstance().selectGuestById(new Guest(rs.getString("GUEST_ID")));
		Designer designer = DesignerDaoImpl.getInstance().selectDesignerByNo(new Designer(rs.getInt("DE_NO")));
		int ordersTotalPrice = rs.getInt("ORDERS_TOTAL_PRICE");
		LocalDateTime ordersDate = rs.getTimestamp("ORDERS_DATE").toLocalDateTime();
		
		ArrayList<OrderDetail> odList = selectOrderDetailsByOrdersNo(ordersNo);
		
		order = new Orders(ordersNo, guest, designer, ordersTotalPrice, ordersDate, odList);
		
		return order;
	}

	@Override
	public ArrayList<Orders> selectOrdersByGuest(Guest guest) {
		String sql = "SELECT * FROM ORDERS WHERE GUEST_ID = ? ORDER BY ORDERS_NO DESC";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, guest.getGuestId());
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					ArrayList<Orders> orderList = new ArrayList<>();
					do {
						orderList.add(getOrders(rs));
					} while(rs.next());
					return orderList;
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException();
		}
		return null;
	}

	@Override
	public Orders selectOrdersByOrdersNo(int ordersNo) {
		String sql = "SELECT * FROM ORDERS WHERE ORDERS_NO = ?";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, ordersNo);
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					return getOrders(rs);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException();
		}
		return null;
	}

	// 단독으로 쓰일 일은 없고, select .. from orders 할 때 odList를 얻어올 때 쓰임.
	@Override
	public ArrayList<OrderDetail> selectOrderDetailsByOrdersNo(int ordersNo) {
		String sql = "SELECT * FROM OD_guest_HAIR_COUPON_view WHERE ORDERS_NO = ? ORDER BY COUPON_ID, OD_NO";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, ordersNo);
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					ArrayList<OrderDetail> odList = new ArrayList<>();
					do {
						odList.add(getOrderDetail(rs));
					} while(rs.next());
					return odList;
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException();
		}
		return null;
	}

	private OrderDetail getOrderDetail(ResultSet rs) throws SQLException {
		// OD_NO,COUPON_ID,HAIR_NO,ORDERS_NO,OD_PRICE,OD_QUANTITY,OD_DISCOUNT,HAIR_NAME,EVENT_NAME
		// OD_NO, ORDER_NO, HAIR_NO, OD_PRICE, OD_QUANTITY, EVENT_NO, OD_DISCOUNT
		int odNo = rs.getInt("OD_NO");
		
		Hair hair = new Hair(rs.getInt("hair_NO"));
		hair.setHairName(rs.getString("HAIR_NAME"));
		
		int odPrice = rs.getInt("OD_PRICE");
		int odQuantity = rs.getInt("OD_QUANTITY");
		
		Coupon coupon = null;
		Event event = null;
		int odDiscount = 0;
		
		try {
			coupon = new Coupon(rs.getInt("COUPON_ID"));
			event = new Event();
			event.setEventName(rs.getString("EVENT_NAME"));
			coupon.setEvent(event);
			odDiscount = rs.getInt("OD_DISCOUNT");
		} catch(SQLException e) {
		}
		
		return new OrderDetail(odNo, hair, odPrice, odQuantity, coupon, odDiscount);
	}

	
	@Override
	public int selectMaxOrdersNo() {
		String sql = "SELECT NVL(MAX(ORDERS_NO), 0) FROM ORDERS";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if(rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			throw new RuntimeException();
		}
		
		return 0;
	}
	
	@Override
	public int selectNextValOrdersNo() {
		String sql = "SELECT ORDERS_NO_SEQ.NEXTVAL FROM DUAL";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if(rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			throw new RuntimeException();
		}
		
		return 0;
	}

	
	@Override
	public int countOrdersByConditionForPaging(Paging paging, String where, String query, String designer, String membership, String startDate, String endDate) {
		String sql = "SELECT COUNT(*) FROM orders ";
		int cnt = 0;
		
		if(where == null) {
		} else if(where.trim().equals("")) {
		} else {
			if(where.trim().equals("guestId")) {
				where = "guest_id";
			} else if (where.equals("guestName")) {
				where = "guest_name";
			} else if (where.equals("guestPhone")) {
				where = "REGEXP_REPLACE(guest_phone, '[^0-9]+')";
			}
			sql += " WHERE " + where + " LIKE '%" + query + "%'";
			cnt++;
		}
		
		if(designer == null) {
		} else if (designer.trim().equals("")) {
		} else {
			if(cnt == 0) {
				sql += " WHERE DE_NO = " + designer;
			} else {
				sql += " AND DE_NO = " + designer;
			}
			cnt++;
		}
		
		if(membership == null) {
		} else if (membership.trim().equalsIgnoreCase("y") || membership.trim().equalsIgnoreCase("n")) {
			if(cnt == 0) {
				sql += " WHERE ";
			} else {
				sql += " AND ";
			}
			if(membership.equalsIgnoreCase("y")) {
				sql += "GUEST_ID != 'nonmember' ";
			} else {
				sql += "GUEST_ID = 'nonmember' ";
			}
			cnt++;
		}
		
		// WHERE orders_date > TO_DATE('2020-11-04') AND orders_date < to_date('2020-11-05') + 1;
		if(startDate == null) {
		} else if (startDate.trim().equals("")) {
		} else {
			if(cnt == 0) {
				sql += " WHERE ORDERS_DATE > TO_DATE('" + startDate + "') ";
			} else {
				sql += " AND DE_NO = " + designer;
			}
			cnt++;
		}
		
		if(endDate == null) {
		} else if (endDate.trim().equals("")) {
		} else {
			if(cnt == 0) {
				sql += " WHERE ORDERS_DATE < TO_DATE('" + endDate + "') + 1 ";
			} else {
				sql += " AND ORDERS_DATE < TO_DATE('" + endDate + "') + 1 ";
			}
			cnt++;
		}
		
		try(Connection con = JndiDs.getConnection();
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
	public ArrayList<Orders> selectOrdersByCondition(Paging paging, String where, String query, String designer, String membership, String startDate, String endDate) {
		
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM orders_guest_view ";
		int cnt = 0;
		
		if(where == null) {
		} else if(where.equals("")) {
		} else {
			if(where.trim().equals("guestId")) {
				where = "guest_id";
			} else if (where.equals("guestName")) {
				where = "guest_name";
			} else if (where.equals("guestPhone")) {
				where = "REGEXP_REPLACE(guest_phone, '[^0-9]+')";
			}
			sql += " WHERE " + where + " LIKE '%" + query + "%' ";
			cnt++;
		}
		
		if(designer == null) {
		} else if (designer.trim().equals("")) {
		} else {
			if(cnt == 0) {
				sql += " WHERE DE_NO = " + designer;
			} else {
				sql += " AND DE_NO = " + designer;
			}
			cnt++;
		}
		
		if(membership == null) {
		} else if (membership.trim().equalsIgnoreCase("y") || membership.trim().equalsIgnoreCase("n")) {
			if(cnt == 0) {
				sql += " WHERE ";
			} else {
				sql += " AND ";
			}
			if(membership.equalsIgnoreCase("y")) {
				sql += "GUEST_ID != 'nonmember' ";
			} else {
				sql += "GUEST_ID = 'nonmember' ";
			}
			cnt++;
		}
		
		// WHERE orders_date > TO_DATE('2020-11-04') AND orders_date < to_date('2020-11-05') + 1;
		if(startDate == null) {
		} else if (startDate.trim().equals("")) {
		} else {
			if(cnt == 0) {
				sql += " WHERE ORDERS_DATE > TO_DATE('" + startDate + "') ";
			} else {
				sql += " AND DE_NO = " + designer;
			}
			cnt++;
		}
		
		if(endDate == null) {
		} else if (endDate.trim().equals("")) {
		} else {
			if(cnt == 0) {
				sql += " WHERE ORDERS_DATE < TO_DATE('" + endDate + "') + 1 ";
			} else {
				sql += " AND ORDERS_DATE < TO_DATE('" + endDate + "') + 1 ";
			}
			cnt++;
		}
		
		sql += " ORDER BY orders_no desc) a) WHERE rn BETWEEN ? AND ? ORDER BY rn";
		
		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, paging.getStart());
			pstmt.setInt(2, paging.getEnd());
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					ArrayList<Orders> list = new ArrayList<>();
					do {
						list.add(getOrders(rs));
					}while(rs.next());
					return list;
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		
		return null;
	}
	
	
//마이페이지///////////////////////////////////////////////////////////////////////////////////////////////	

	@Override
	public ArrayList<Orders> pagingOrdersListById(Paging paging, String id) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM ORDERS WHERE GUEST_ID = ? ORDER BY ORDERS_NO desc) a) "
				+ "WHERE rn BETWEEN ? AND ? ORDER BY rn";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, id);
			pstmt.setInt(2, paging.getStart());
			pstmt.setInt(3, paging.getEnd());
			try(ResultSet rs = pstmt.executeQuery()){
					if(rs.next()) {		
						ArrayList<Orders> list = new ArrayList<Orders>();
							//ORDERS_NO,ORDERS_DATE,DE_NO,GUEST_ID,ORDERS_TOTAL_PRICE
						
						do{ 
							Orders orders = new Orders();
							DesignerDao dDao = DesignerDaoImpl.getInstance();
							GuestDao gDao = GuestDaoImpl.getInstance();
							HairDao hDao = HairDaoImpl.getInstance();
							
							int ordersNo = rs.getInt("ORDERS_NO");
							orders.setOrdersNo(ordersNo);
							orders.setOrdersDate(rs.getTimestamp("ORDERS_DATE").toLocalDateTime());
							orders.setDesigner(dDao.selectDesignerByNo(new Designer(rs.getInt("DE_NO"))));
							orders.setGuest(gDao.selectGuestById(new Guest(rs.getString("GUEST_ID"))));
							orders.setOrdersTotalPrice(rs.getInt("ORDERS_TOTAL_PRICE"));
								
							ArrayList<OrderDetail> odList = selectOrderDetailsByOrdersNo(ordersNo);
							orders.setOdList(odList);
								
							list.add(orders);
						}while (rs.next());
						return list;
					}
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
			return null;
		}
				
				

	@Override
	public int countOrdersById(String id) {
		String sql = "SELECT COUNT(*) FROM (SELECT orders_no FROM ORDERS WHERE guest_id = ?)";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
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
