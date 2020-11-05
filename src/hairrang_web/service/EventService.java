package hairrang_web.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import hairrang_web.dao.EventDao;
import hairrang_web.dao.impl.EventDaoImpl;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Event;
import hairrang_web.utils.Paging;

public class EventService {
	EventDao dao = EventDaoImpl.getInstance();
	
	public ArrayList<Event> selectEventAllForBoard(){
		return dao.selectEventAllForBoard();
	}
	
	public ArrayList<Event> selectEventAll(){
		return dao.selectEventAll();
	}
	
	public Event selectEventByNo(Event event) {
		return dao.selectEventByNo(event);
	}
	public ArrayList<Event> selectEventSide(Event event){
		ArrayList<Event> list = new ArrayList<Event>();
		list.add(dao.selectEventDownSide(event));
		list.add(dao.selectEventUpSide(event));
		return list;
	}
	
	//페이징
	public int countEvent() {
		return dao.countEvent();
	}
	
	public ArrayList<Event> PagingEventAll(Paging paging){
		return dao.PagingEventAll(paging);
	}
	
	public int updateEvent(Event event) {
		String eSql = "UPDATE EVENT SET EVENT_NAME = ?, EVENT_SALERATE = ?, EVENT_START = ?,EVENT_END = ? + - 1 / (24*60*60) + 1, "
				+ "EVENT_PIC = ?, EVENT_CONTENT = ? WHERE EVENT_NO = ?";
		//COUPON_ID,GUEST_ID,EVENT_NO,EVENT_START,EVENT_END,USED_YN
		String cSql = "UPDATE COUPON SET EVENT_START = ?, EVENT_END = ? + - 1 / (24*60*60) + 1 WHERE EVENT_NO = ? ";
		
		Connection con = null;
        PreparedStatement ePstmt = null;
        PreparedStatement cPstmt = null;
        
        try {
        	con = JndiDs.getConnection();
			con.setAutoCommit(false);
			
			ePstmt = con.prepareStatement(eSql);
			
			ePstmt.setString(1, event.getEventName());
			ePstmt.setDouble(2, event.getEventSaleRate());
			ePstmt.setDate(3, Date.valueOf(event.getEventStart()));
			ePstmt.setDate(4, Date.valueOf(event.getEventEnd()));
			ePstmt.setString(5, event.getEventPic());
			ePstmt.setString(6, event.getEventContent());
			ePstmt.setInt(7, event.getEventNo());
			ePstmt.executeUpdate();
			
			cPstmt = con.prepareStatement(cSql);
			cPstmt.setDate(1, Date.valueOf(event.getEventStart()));
			cPstmt.setDate(2, Date.valueOf(event.getEventEnd()));
			cPstmt.setInt(3, event.getEventNo());
			
			cPstmt.executeUpdate();
			
			con.commit();
			
        } catch (SQLException e) {
			rollbackUtil(con, e);
		} finally {
            closeUtil(con, ePstmt, cPstmt);
        }
		return 0;
	}
	
	public int deleteEvent(Event event) {
		//대기중 이벤트 삭제와 동시에 발급된 회원쿠폰 삭제
		String cSql = "delete coupon where event_no = ?";
		String eSql = "DELETE EVENT WHERE EVENT_NO = ?";
		
		Connection con = null;
        PreparedStatement ePstmt = null;
        PreparedStatement cPstmt = null;
        
        
		try {
			con = JndiDs.getConnection();
			con.setAutoCommit(false);
			
			cPstmt = con.prepareStatement(cSql);
			cPstmt.setInt(1, event.getEventNo());
			
			cPstmt.executeUpdate();
			

			ePstmt = con.prepareStatement(eSql);
			ePstmt.setInt(1, event.getEventNo());
			
			ePstmt.executeUpdate();
			
			con.commit();
		
		} catch (SQLException e) {
			rollbackUtil(con, e);
		} finally {
            closeUtil(con, ePstmt, cPstmt);
        }
		return 0;
	}
	
	public int insertEvent(Event event) {
		//insertevent랑 동시에 전체회원에게 쿠폰 삽입
		//생일쿠폰은 개별 생일 10일전 발급 -> 10일후까지 사용가능
		String eSql = "INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT) "
				+ "VALUES(?, ?, ?, ? + - 1 / (24*60*60) + 1, ?, ?)";
		String cSql = "INSERT INTO COUPON(guest_id, EVENT_NO, EVENT_START, EVENT_END) SELECT guest_id, EVENT_NO, EVENT_START, EVENT_END "
				+ "FROM (SELECT g.*, 1 AS fake FROM guest_view g WHERE del_yn = 'n' ) g "
				+ "LEFT OUTER JOIN (SELECT e.*, 1 AS fake FROM EVENT e WHERE event_no = ?) USING (FAKE)";
		
		Connection con = null;
        PreparedStatement ePstmt = null;
        PreparedStatement cPstmt = null;
        int maxEventNo = 1;
        
		try {
			con = JndiDs.getConnection();
			con.setAutoCommit(false);
			
			ePstmt = con.prepareStatement(eSql);
			
			ePstmt.setString(1, event.getEventName());
			ePstmt.setDouble(2, event.getEventSaleRate());
			ePstmt.setDate(3, Date.valueOf(event.getEventStart()));
			ePstmt.setDate(4, Date.valueOf(event.getEventEnd()));
			ePstmt.setString(5, event.getEventPic());
			ePstmt.setString(6, event.getEventContent());
			
			ePstmt.executeUpdate();
			con.commit();
			
			maxEventNo = dao.selectMaxEventNo();
			System.out.println("마지막이벤트번호:" + maxEventNo);
			cPstmt = con.prepareStatement(cSql);
			cPstmt.setInt(1, maxEventNo);
			
			cPstmt.executeUpdate();
			
			con.commit();
			
		
		} catch (SQLException e) {
			rollbackUtil(con, e);
		} finally {
            closeUtil(con, ePstmt, cPstmt);
        }
		return maxEventNo;
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
