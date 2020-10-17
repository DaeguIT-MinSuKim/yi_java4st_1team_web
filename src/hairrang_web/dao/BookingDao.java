package hairrang_web.dao;

import java.util.ArrayList;
import java.util.List;

import hairrang_web.dto.Booking;
import hairrang_web.dto.Guest;
import hairrang_web.dto.TimeTable;
import hairrang_web.utils.Paging;

public interface BookingDao {

	ArrayList<Booking> selectBookingAll();
	
	Booking selectBookingByBookingNo(Booking booking);
	
	ArrayList<Booking> selectBookingByGuestId(Guest guest);
	
	int insertBooking(Booking booking);
	
	int updateBooking(Booking booking);
	
	int deleteBooking(Booking booking);
	
	int checkUser(Booking booking, Guest guest);

	int selectMaxBookNo();

	ArrayList<TimeTable> getTimeTables(String wantDate);

	int countBookingById(String id);
	
	List<Booking> pagingBookingById(Paging paging, String id);

	int isAvailableTime(String wantDateTime);

}
