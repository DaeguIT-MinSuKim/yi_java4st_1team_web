package hairrang_web.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import hairrang_web.dao.OrdersDao;
import hairrang_web.dao.impl.OrdersDaoImpl;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Guest;
import hairrang_web.dto.OrderDetail;
import hairrang_web.dto.Orders;

public class OrdersService {

	private OrdersDao dao = OrdersDaoImpl.getInstance();
	
	// 전체 주문 리스트
	public ArrayList<Orders> getOrdersListAll() {
		return dao.selectOrdersAll();
	}
	
	// 한 회원의 주문 내역들
	public ArrayList<Orders> getOrdersListByGuest(Guest guest) {
		return dao.selectOrdersByGuest(guest);
	}
	
	// 주문번호 1건
	public Orders getOrderOneByOrdersNo(int ordersNo) {
		return dao.selectOrdersByOrdersNo(ordersNo);
	}
	
	// 해당 주문의 상세주문 리스트
	// 단독으로 쓰일 일은 없고, orders를 구할 때 내부적으로 사용될 것임
	/*
	ArrayList<OrderDetail> getOrderDetailListByOrdersNo(int ordersNo) {
		return dao.selectOrderDetailsByOrdersNo(ordersNo);
	}
	*/
	
	// int, update, delete는 트랜잭션 적용으로 service에서 구현.
	public int insertOrders(Orders orders) {
		String oSql = "INSERT INTO orders(guest_id, de_no) VALUES(?, ?)";
		String odSql = "INSERT INTO ORDER_DETAIL(HAIR_NO, OD_PRICE, OD_QUANTITY, COUPON_ID, OD_DISCOUNT) " + 
				"SELECT HAIR_NO, hair_price, ?, coupon_id, hair_price*event_salerate " + 
				"FROM (SELECT HAIR_NO, hair_price, 0 AS fake FROM hair WHERE hair_no = ?) " + 
				"LEFT OUTER JOIN (SELECT coupon_id, event_salerate, 0 AS fake FROM coupon_view WHERE coupon_id = ? AND GUEST_ID = ?) USING(fake)";
		
		Connection con = null;
		PreparedStatement oPstmt = null;
		PreparedStatement odPstmt = null;
		int ordersNo = 0;
		
		try {
			con = JndiDs.getConnection();
			con.setAutoCommit(false);
			
			oPstmt = con.prepareStatement(oSql);
					
			String guestId = orders.getGuest().getGuestId();
			oPstmt.setString(1, guestId);
			oPstmt.setInt(2,  orders.getDesigner().getDeNo());
			
			oPstmt.executeUpdate();
			
			odPstmt = con.prepareStatement(odSql);
			ordersNo = dao.selectMaxOrdersNo() + 1;
			
			for(OrderDetail od : orders.getOdList()) {
//				odPstmt.setInt(1, ordersNo);
				odPstmt.setInt(1, od.getOdQuantity());
				odPstmt.setInt(2, od.getHair().getHairNo());
				if(od.getCoupon() != null) {
					odPstmt.setInt(3, od.getCoupon().getCouponId());
				} else {
					odPstmt.setString(3, null);
				}
				odPstmt.setString(4, guestId);
				odPstmt.executeUpdate();
			}
			
			con.commit();
		} catch (SQLException e) {
			rollbackUtil(con, e);
			ordersNo = 0;
		} finally {
			closeUtil(con, oPstmt, odPstmt);
		}
		
		return ordersNo;
	}
	
	
	private void rollbackUtil(Connection con, SQLException e) {
        try {
            System.out.println("roll back");
            con.rollback();
            throw new RuntimeException(e);
        } catch (SQLException ex) {
        }
    }

    private void closeUtil(Connection con, PreparedStatement dPstmt, PreparedStatement tPstmt) {
        try {
            if (dPstmt != null) {
                dPstmt.close();
            }
            if (tPstmt != null) {
                tPstmt.close();
            }
            if (con != null) {
                con.setAutoCommit(true);
                con.close();
            }
        } catch (SQLException ex) {
        }
    }
	
}
