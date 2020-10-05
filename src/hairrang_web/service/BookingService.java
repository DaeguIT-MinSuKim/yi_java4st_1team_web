package hairrang_web.service;

import hairrang_web.dao.BookingDao;
import hairrang_web.dao.impl.BookingDaoImpl;
import hairrang_web.dto.Booking;
import hairrang_web.dto.Guest;

public class BookingService {

	private BookingDao dao = BookingDaoImpl.getInstance();
	
	public Booking getBookingByBookingNo(Booking booking) {
		return dao.selectBookingByBookingNo(booking);
	}
	
	public int checkUser(Booking booking, Guest guest) {
		return dao.checkUser(booking, guest);
	}
}
