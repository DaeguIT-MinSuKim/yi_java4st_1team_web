package hairrang_web.dao;

import java.util.ArrayList;

import hairrang_web.dto.Booking;

public interface BookingDao {

	ArrayList<Booking> selectBookingAll();
	
	Booking selectBookingByBookingNo(Booking booking);
	
	int insertBooking(Booking booking);
	
	int updateBooking(Booking booking);
	
	int deleteBooking(Booking booking);
	
//	int checkPwd(String id, String pwd);
}
