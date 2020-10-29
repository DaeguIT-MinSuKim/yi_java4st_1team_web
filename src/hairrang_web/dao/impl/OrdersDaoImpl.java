package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;

import hairrang_web.dao.OrdersDao;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Coupon;
import hairrang_web.dto.Designer;
import hairrang_web.dto.Guest;
import hairrang_web.dto.Hair;
import hairrang_web.dto.OrderDetail;
import hairrang_web.dto.Orders;

public class OrdersDaoImpl implements OrdersDao {

	public static final OrdersDaoImpl instance = new OrdersDaoImpl();
	
	private OrdersDaoImpl() {
	}
	
	public static OrdersDaoImpl getInstance() {
		return instance;
	}


	@Override
	public ArrayList<Orders> selectOrdersAll() {
		String sql = "SELECT * FROM ORDERS ORDER BY ORDERS_NO";
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
		
		int ordersNo = rs.getInt("ORDERS_NO");
		Guest guest = GuestDaoImpl.getInstance().selectGuestById(new Guest(rs.getString("GUEST_ID")));
		Designer designer = DesignerDaoImpl.getInstance().selectDesignerByNo(new Designer(rs.getInt("DE_NO")));
		int ordersTotalPrice = rs.getInt("ORDERS_TOTAL_PRICE");
		LocalDateTime ordersDate = rs.getTimestamp("ORDERS_DATE").toLocalDateTime();
		
		ArrayList<OrderDetail> odList = selectOrderDetailsByOrdersNo(ordersNo);
		
		return new Orders(ordersNo, guest, designer, ordersTotalPrice, ordersDate, odList);
	}

	@Override
	public ArrayList<Orders> selectOrdersByGuest(Guest guest) {
		String sql = "SELECT * FROM ORDERS BY GUEST_ID = ?";
		
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
		String sql = "SELECT * FROM ORDERS FROM ORDERS_NO = ";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if(rs.next()) {
				return getOrders(rs);
			}
		} catch (SQLException e) {
			throw new RuntimeException();
		}
		return null;
	}

	// 단독으로 쓰일 일은 없고, select .. from orders 할 때 odList를 얻어올 때 쓰임.
	@Override
	public ArrayList<OrderDetail> selectOrderDetailsByOrdersNo(int ordersNo) {
		String sql = "SELECT * FROM ORDER_DETAIL WHERE ORDERS_NO = ? ORDER BY ORDERS_NO, COUPON_ID, OD_NO";
		
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
		// OD_NO, ORDER_NO, HAIR_NO, OD_PRICE, OD_QUANTITY, EVENT_NO, OD_DISCOUNT
		int odNo = rs.getInt("OD_NO");
		Hair hair = HairDaoImpl.getInstance().selectHairByNo(new Hair(rs.getInt("HAIR_NO")));
		int odPrice = rs.getInt("OD_PRICE");
		int odQuantity = rs.getInt("OD_QUANTITY");
		Coupon coupon = CouponDaoImpl.getInstance().selectCouponByCouponId(new Coupon(rs.getInt("COUPON_ID")));
		int odDiscount = rs.getInt("OD_DISCOUNT");
		
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

}
