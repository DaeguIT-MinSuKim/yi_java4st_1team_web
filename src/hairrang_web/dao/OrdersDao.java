package hairrang_web.dao;

import java.util.ArrayList;

import hairrang_web.dto.Guest;
import hairrang_web.dto.OrderDetail;
import hairrang_web.dto.Orders;
import hairrang_web.utils.Paging;

public interface OrdersDao {

	// 전체 주문 리스트
	ArrayList<Orders> selectOrdersAll();
	
	// 한 회원의 주문 내역들
	ArrayList<Orders> selectOrdersByGuest(Guest guest);
	
	// 주문번호 1건
	Orders selectOrdersByOrdersNo(int ordersNo);
	
	// 해당 주문의 상세주문 리스트
	// 단독으로 쓰일 일은 없고, orders를 구할 때 내부적으로 사용될 것임
	ArrayList<OrderDetail> selectOrderDetailsByOrdersNo(int ordersNo);
	
	int selectMaxOrdersNo();

	int selectNextValOrdersNo();

	// 페이징
	int countOrdersByConditionForPaging(Paging paging, String where, String query, String sorter);
	ArrayList<Orders> selectOrdersByCondition(Paging paging, String where, String query, String sorter);
	
	// int, update, delete는 트랜잭션 적용으로 service에서 구현.
}
