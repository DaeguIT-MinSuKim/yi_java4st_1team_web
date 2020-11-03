package hairrang_web.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.mail.MessagingException;

import hairrang_web.controller.mail.SendMail;
import hairrang_web.dao.BookingDao;
import hairrang_web.dao.impl.BookingDaoImpl;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Booking;
import hairrang_web.dto.BookingHairs;
import hairrang_web.dto.Guest;
import hairrang_web.dto.TimeTable;
import hairrang_web.utils.Paging;

public class BookingService {

	private BookingDao dao = BookingDaoImpl.getInstance();
	
	public ArrayList<Booking> getBookingListAll() {
		return dao.selectBookingAll();
	}
	
	public Booking getBookingByBookingNo(Booking booking) {
		return dao.selectBookingByBookingNo(booking);
	}
	
	public ArrayList<Booking> getBookingByGuestId(String id) {
		return dao.selectBookingByGuestId(new Guest(id));
	}
	
	public int checkUser(Booking booking, Guest guest) {
		return dao.checkUser(booking, guest);
	}

	/*
	public int addBooking(Booking booking) {
		return dao.insertBooking(booking);
	}
	*/
	
	// 현재 테이블에서 가장 최근의 nookNo
	public int getMaxBookNo() {
		return dao.selectMaxBookNo();
	}
	
	// insert시 다음에 삽입할 bookNo 구하기
	public int getNextBookNo() {
		return dao.selectMaxBookNo() + 1;
	}
	
	public ArrayList<TimeTable> getTimeTable(String wantDate, int deNo) {
		return dao.getTimeTables(wantDate, deNo);
	}
	
	public int isAvailableTime(String wantDateTime, int deNo) {
		return dao.isAvailableTime(wantDateTime, deNo);
	}
	
	public int countBookingById(String id) {
		return dao.countBookingById(id);
	}
	
	public int countStatus1(String id) {
		return dao.countStatus1(id);
	}
	
	public int countStatus0(String id) {
		return dao.countStatus0(id);
	}
	
	public Booking pagingBookingById(Paging paging, String id, int no) {
		return dao.pagingBookingById(paging, id, no);
	}
	
	public ArrayList<Booking> pagingBookingListById(Paging paging, String id) {
		return dao.pagingBookingListById(paging, id);
	}
	
	public ArrayList<BookingHairs> pagingBookingHairsByID(Paging paging, String id){
		return dao.pagingBookingHairsById(paging, id);
	}
	
	public ArrayList<BookingHairs> selectBookingHairsByBookingNo(int bookNo){
		return dao.selectBookingHairsByBookingNo(bookNo);
	}
	
	public int updateBookingStatus(Booking booking) {
		return dao.updateBookingStaus(booking);
	}
	
	
	public Booking selectBookStatus1(Paging paging, String id, int no) {
		return dao.selectBookStatus1(paging, id, no);
	}
	
	public Booking selectBookStatus0(Paging paging, String id, int no) {
		return dao.selectBookStatus0(paging, id, no);
	}
	
	public ArrayList<Integer> selectNoBooking(String id){
		return dao.selectNoBooking(id);
	}
	
	public ArrayList<Integer> selectNoStatus0 (String id){
		return dao.selectNoStatus0(id);
	}
	
	public ArrayList<Integer> selectNoStatus1 (String id){
		return dao.selectNoStatus1(id);
	}
	
	public int updateBookingStatus(String[] list) {
		String sql = "UPDATE booking SET BOOK_STATUS = 0 WHERE book_no = ?";
		
		Connection con = null;
		PreparedStatement pstmt = null;
		int res = 0;
		
		try {
			con = JndiDs.getConnection();
			con.setAutoCommit(false);
			
			pstmt = con.prepareStatement(sql);
			
			for(String bookNo : list) {
				pstmt.setInt(1, Integer.parseInt(bookNo));
				pstmt.addBatch();
			}
			
			pstmt.executeBatch();
			
			try {
				for(String bookNo : list ) {
					Booking booking = dao.selectBookingByBookingNo(new Booking(Integer.parseInt(bookNo)));
					Guest guest = booking.getGuest();
					
					BookingCancelSendEmail emailThr = new BookingCancelSendEmail();
					emailThr.setGuest(guest);
					emailThr.setBooking(booking);
					
					Thread t = new Thread(emailThr);
					t.start();
				}
			}catch(Exception e) {
				throw new RuntimeException();
			}
			
			res = 1;
		} catch (SQLException e) {
			System.out.println("예약 취소 중 에러!");
			rollbackUtil(con, e);
		} finally {
			closeUtil(con, pstmt);
		}
		
		return res;
	}
	
	public int insertBookingWithHairList(Booking booking) {
		String bookingSql = "INSERT INTO BOOKING(BOOK_NO, GUEST_ID, BOOK_TIME, DE_NO, BOOK_NOTE) VALUES(?, ?, ?, ?, ?)";
		String hairsSql = "INSERT INTO BOOKING_HAIRS(BOOK_NO, HAIR_NO, HAIR_QUANTITY) VALUES(?, ?, ?)";
		
		Connection con = null;
		PreparedStatement bookingPstmt = null;
		PreparedStatement hairsPstmt = null;
		int bookingNo = 0;
		
		try {
			con = JndiDs.getConnection();
			con.setAutoCommit(false);
			
			bookingPstmt = con.prepareStatement(bookingSql);
			
			bookingNo = dao.selectNextValBookNo();
			
			bookingPstmt.setInt(1, bookingNo);
			bookingPstmt.setString(2, booking.getGuest().getGuestId());
			bookingPstmt.setTimestamp(3, Timestamp.valueOf(booking.getBookDate()));
			bookingPstmt.setInt(4, booking.getDesigner().getDeNo());
			bookingPstmt.setString(5, booking.getBookNote());
			
			bookingPstmt.executeUpdate();
			
			System.out.println("booking 삽입?");
			
			hairsPstmt = con.prepareStatement(hairsSql);
			
			for(BookingHairs hs : booking.getHairList()) {
				hairsPstmt.setInt(1, bookingNo);
				hairsPstmt.setInt(2, hs.getHair().getHairNo());
				hairsPstmt.setInt(3, hs.getQuantity());
				hairsPstmt.executeUpdate();
			}
			
			con.commit();
		} catch (SQLException e) {
			System.out.println("예약 인서트 중 에러!");
			rollbackUtil(con, e);
		} finally {
			closeUtil(con, bookingPstmt, hairsPstmt);
		}
		
		return bookingNo;
	}
	
	private void rollbackUtil(Connection con, SQLException e) {
        try {
            System.out.println("roll back");
            con.rollback();
            throw new RuntimeException(e);
        } catch (SQLException ex) {
        }
    }

    private void closeUtil(Connection con, PreparedStatement...pstmt) {
        try {
        	for(PreparedStatement p:pstmt) {
        		if(p != null) {
        			p.close();
        		}
        	}
            if (con != null) {
                con.setAutoCommit(true);
                con.close();
            }
        } catch (SQLException ex) {
        }
    }

    
    public ArrayList<Booking> getTodayBookingList() {
    	return dao.selectBookingAllToday();
    }
    
    
    public ArrayList<Booking> getBookingListBySearch(Paging paging, String where, String query, String sorter, String designer, String startDate, String endDate) {
    	return dao.selectBookingByCondition(paging, where, query, sorter, designer, startDate, endDate);
    }
    
    public int getTotalCountBySearch(Paging paging, String where, String query, String sorter, String designer, String startDate, String endDate) {
    	return dao.countBookingByConditionForPaging(paging, where, query, sorter, designer, startDate, endDate);
	}
	
}
