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
			
//			for(String bookNo : list ) {
//				Booking booking = dao.selectBookingByBookingNo(new Booking(Integer.parseInt(bookNo)));
//				Guest guest = booking.getGuest();
//				sendBookingInfoEmail(booking, guest);
//			}
			
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
		String bookingSql = "INSERT INTO BOOKING(GUEST_ID, BOOK_TIME, DE_NO, BOOK_NOTE) VALUES(?, ?, ?, ?)";
		String hairsSql = "INSERT INTO BOOKING_HAIRS(HAIR_NO, HAIR_QUANTITY) VALUES(?, ?)";
		
		Connection con = null;
		PreparedStatement bookingPstmt = null;
		PreparedStatement hairsPstmt = null;
		int bookingNo = 0;
		
		try {
			con = JndiDs.getConnection();
			con.setAutoCommit(false);
			
			bookingPstmt = con.prepareStatement(bookingSql);
					
			bookingPstmt.setString(1, booking.getGuest().getGuestId());
			bookingPstmt.setTimestamp(2, Timestamp.valueOf(booking.getBookDate()));
			bookingPstmt.setInt(3, booking.getDesigner().getDeNo());
			bookingPstmt.setString(4, booking.getBookNote());
			
			bookingPstmt.executeUpdate();
			
			hairsPstmt = con.prepareStatement(hairsSql);
			bookingNo = dao.selectMaxBookNo() + 1; // 커밋되기 전이어서 +1 해줘야 함
			
			for(BookingHairs hs : booking.getHairList()) {
				hairsPstmt.setInt(1, bookingNo);
				hairsPstmt.setInt(1, hs.getHair().getHairNo());
				hairsPstmt.setInt(2, hs.getQuantity());
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
    
    
    public ArrayList<Booking> getBookingListBySearch(Paging paging, String where, String query, String sorter, String designer) {
    	return dao.selectBookingByCondition(paging, where, query, sorter, designer);
    }
    
    public int getTotalCountBySearch(Paging paging, String where, String query, String sorter, String designer) {
    	return dao.countBookingByConditionForPaging(paging, where, query, sorter, designer);
	}
	
    private void sendBookingInfoEmail(Booking booking, Guest guest) {
		/* 예약 완료 메일 전송 */
		String from = "official.hairrang@gmail.com"; //  보내는 사람
		String to = guest.getGuestEmail();// 받는 사람
		String cc = ""; // 참조
		String subject = "[Hairrang] 고객님의 예약이 취소되었습니다.";// 제목
		
		String content = "<table>" + 
				"	<h4>예약 정보 </h4>" + 
				"	<tr style=\"border-top:1px solid #e4e4e4;\">" + 
				"		<td>예약 번호</td><td>" + booking.getBookNo() + 
				"		</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td>예약등록일</td>" + 
				"		<td><s>" + booking.getBookRegDateStr() +
				"		</s></td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td>예약자</td><td>" + guest.getGuestName() + "(" + guest.getGuestId() + ")</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td>연락처</td><td>"+ guest.getGuestPhone() + "</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td>예약 상태</td><td>예약 취소</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td>이용 날짜</td> " + 
				"		<td><s>" + booking.getBookDateStr() +
				"		</s></td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td>담당 디자이너</td>" + 
				"		<td>"+ booking.getDesigner().getDeNickname() + "</td>" + 
				"	</tr>" + 
				"</table>" + 
				"<br><br>" + 
				"<h4>시술 정보</h4>" + 
				"<table>" + 
				"	<tr>" + 
				"		<td style=\"border-top:1px solid #e4e4e4; width:250px;\">시술 정보</td> " + 
				"		<td style=\"border-top:1px solid #e4e4e4; width:50px;\">가격</td> " + 
				"		<td style=\"border-top:1px solid #e4e4e4; width:50px;\">수량</td>" + 
				"	</tr>";
		int sum = 0;
		for(BookingHairs hairs : booking.getHairList()) {
			content += "<tr>"
					+ "	<td>" + hairs.getHair().getHairName() + "</td>" 
					+ "	<td>" + String.format("%,d", hairs.getHair().getHairPrice())+ "</td>"
					+ "	<td>" + hairs.getQuantity() + "</td>"
					+ "</tr>";
			sum += hairs.getHair().getHairPrice();
		}
		content += "<tr>" + 
					"<td colspan=\"3\" class=\"tright\">합계 : <b style=\"font-weight:bold\">" + String.format("%,d", sum)+ "원</b></td>" + 
					"</tr>" + 
					"</table>";

		if (to.trim().equals("")) {
			System.out.println("받는 사람을 입력하지 않았습니다.");

		} else {
			try {
				//메일 
				SendMail sm = new SendMail();
				sm.sendEmail(from, to, cc, subject, content);
				System.out.println("메일 전송에 성공하였습니다.");
			} catch (MessagingException me) {
				System.out.println("메일 전송에 실패하였습니다.");
				System.out.println("실패 이유 : " + me.getMessage());
			} catch (Exception e) {
				System.out.println("메일 전송에 실패하였습니다.");
				System.out.println("실패 이유 : " + e.getMessage());
			}
		}
	}
}
