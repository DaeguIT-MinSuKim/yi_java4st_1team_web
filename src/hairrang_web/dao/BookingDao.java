package hairrang_web.dao;

import java.util.ArrayList;

import hairrang_web.dto.Booking;
import hairrang_web.dto.Guest;

public interface BookingDao {

	ArrayList<Booking> selectBookingAll();
	
	Booking selectBookingByBookingNo(Booking booking);
	
	ArrayList<Booking> selectBookingByGuestId(Guest guest);
	
	int insertBooking(Booking booking);
	
	int updateBooking(Booking booking);
	
	int deleteBooking(Booking booking);
	
	int checkUser(Booking booking, Guest guest);

	int selectMaxBookNo();
}
