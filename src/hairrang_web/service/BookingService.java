package hairrang_web.service;

import java.util.ArrayList;

import hairrang_web.dao.BookingDao;
import hairrang_web.dao.impl.BookingDaoImpl;
import hairrang_web.dto.Booking;
import hairrang_web.dto.Guest;
import hairrang_web.dto.TimeTable;

public class BookingService {

	private BookingDao dao = BookingDaoImpl.getInstance();
	
	public Booking getBookingByBookingNo(Booking booking) {
		return dao.selectBookingByBookingNo(booking);
	}
	
	public ArrayList<Booking> getBookingByGuestId(String id) {
		return dao.selectBookingByGuestId(new Guest(id));
	}
	
	public int checkUser(Booking booking, Guest guest) {
		return dao.checkUser(booking, guest);
	}
	
	public int addBooking(Booking booking) {
		return dao.insertBooking(booking);
	}
	
	// 현재 테이블에서 가장 최근의 nookNo
	public int getMaxBookNo() {
		return dao.selectMaxBookNo();
	}
	
	// insert시 다음에 삽입할 bookNo 구하기
	public int getNextBookNo() {
		return dao.selectMaxBookNo() + 1;
	}
	
	public ArrayList<TimeTable> getTimeTable(String wantDate) {
		return dao.getTimeTables(wantDate);
	}
	
	public int countBookingById(String id) {
		return dao.countBookingById(id);
	}
	

}
