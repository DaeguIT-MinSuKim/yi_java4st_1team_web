package hairrang_web.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import hairrang_web.dao.OrdersDao;
import hairrang_web.dao.impl.OrdersDaoImpl;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Booking;
import hairrang_web.dto.Guest;
import hairrang_web.dto.OrderDetail;
import hairrang_web.dto.Orders;
import hairrang_web.utils.Paging;

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
	
	//마이페이지
	public ArrayList<Orders> pagingOrdersListById(Paging paging, String id){
		return dao.pagingOrdersListById(paging, id);
	}
	public int countOrdersById(String id) {
		return dao.countOrdersById(id);
	}

	
	// 해당 주문의 상세주문 리스트
	// 단독으로 쓰일 일은 없고, orders를 구할 때 내부적으로 사용될 것임
	/*
	ArrayList<OrderDetail> getOrderDetailListByOrdersNo(int ordersNo) {
		return dao.selectOrderDetailsByOrdersNo(ordersNo);
	}
	*/
	
	// int, update, delete는 트랜잭션 적용으로 service에서 구현.
	public int insertOrders(Orders orders, int bookNo) {
		String oSql = "INSERT INTO orders(orders_no, guest_id, de_no) VALUES(?, ?, ?)";
		String odSql = "INSERT INTO ORDER_DETAIL(ORDERS_NO, HAIR_NO, OD_PRICE, OD_QUANTITY, COUPON_ID, OD_DISCOUNT) " + 
				"SELECT ?, HAIR_NO, hair_price, ?, coupon_id, hair_price*event_salerate " + 
				"FROM (SELECT HAIR_NO, hair_price, 0 AS fake FROM hair WHERE hair_no = ?) " + 
				"LEFT OUTER JOIN (SELECT coupon_id, event_salerate, 0 AS fake FROM coupon_view WHERE coupon_id = ? AND GUEST_ID = ?) USING(fake)"; 
		String bSql = "UPDATE BOOKING SET BOOK_STATUS = 2 WHERE BOOK_NO = ? ";
		String tpSql = "UPDATE orders SET orders_total_price = (SELECT SUM(OD_PRICE*OD_QUANTITY-NVL(OD_DISCOUNT, 0)) FROM ORDER_DETAIL od WHERE orders_no = ?) WHERE orders_no = ?";
		
		Connection con = null;
		PreparedStatement oPstmt = null;
		PreparedStatement odPstmt = null;
		PreparedStatement bPstmt = null;
		PreparedStatement tpPstmt = null;
		
		int ordersNo = 0;
		System.out.println("orderService insert");
		System.out.println(orders);
		
		try {
			con = JndiDs.getConnection();
			con.setAutoCommit(false);
			
			oPstmt = con.prepareStatement(oSql);
					
			ordersNo = dao.selectNextValOrdersNo();
			
			String guestId = orders.getGuest().getGuestId();
			oPstmt.setInt(1, ordersNo);
			oPstmt.setString(2, guestId);
			oPstmt.setInt(3,  orders.getDesigner().getDeNo());
			
			oPstmt.executeUpdate();
			
			odPstmt = con.prepareStatement(odSql);
			for(OrderDetail od : orders.getOdList()) {
				odPstmt.setInt(1, ordersNo);
				odPstmt.setInt(2, od.getOdQuantity());
				odPstmt.setInt(3, od.getHair().getHairNo());
				System.out.println("쿠폰 있니? " + od.getCoupon());
				if(od.getCoupon() != null) {
					if(od.getCoupon().getCouponId() == 0) {
						odPstmt.setInt(4, od.getCoupon().getCouponId());
					}
					odPstmt.setString(4, null);
				} else {
					odPstmt.setString(4, null);
				}
				odPstmt.setString(5, guestId);
				odPstmt.executeUpdate();
			}
			
			System.out.println("어디서 롤백?");
			
			if(bookNo > 0) {
				bPstmt = con.prepareStatement(bSql);
				bPstmt.setInt(1, bookNo);
				bPstmt.executeUpdate();
			}
			
			con.commit();
			con.setAutoCommit(true);
			
			tpPstmt = con.prepareStatement(tpSql);
			tpPstmt.setInt(1, ordersNo);
			tpPstmt.setInt(2, ordersNo);
			
			tpPstmt.executeUpdate();
			
		} catch (SQLException e) {
			rollbackUtil(con, e);
			/*for(int i = 0; i < backSql.length; i++) {
				try {
					backPstmt = con.prepareStatement(backSql[i]);
					backPstmt.executeUpdate();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}*/
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
	
    
    public ArrayList<Orders> getOrdersListBySearch(Paging paging, String where, String query, String designer) {
    	return dao.selectOrdersByCondition(paging, where, query, designer);
    }
    
    public int getTotalCountBySearch(Paging paging, String where, String query, String designer) {
    	return dao.countOrdersByConditionForPaging(paging, where, query, designer);
	}
}
