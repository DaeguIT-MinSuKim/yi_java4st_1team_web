package hairrang_web.service;

import java.util.ArrayList;

import hairrang_web.dao.BookingDao;
import hairrang_web.dao.impl.BookingDaoImpl;
import hairrang_web.dto.Booking;
import hairrang_web.dto.Guest;

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
}
