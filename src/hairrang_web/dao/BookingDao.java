package hairrang_web.dao;

import java.util.ArrayList;
import java.util.List;

import hairrang_web.dto.Booking;
import hairrang_web.dto.BookingHairs;
import hairrang_web.dto.Guest;
import hairrang_web.dto.TimeTable;
import hairrang_web.utils.Paging;

public interface BookingDao {

	ArrayList<Booking> selectBookingAll();
	
	Booking selectBookingByBookingNo(Booking booking);
	
	ArrayList<Booking> selectBookingByGuestId(Guest guest);
	
	// int insertBooking(Booking booking);
	
	// int updateBooking(Booking booking);
	
	int deleteBooking(Booking booking);
	
	int checkUser(Booking booking, Guest guest);

	int selectMaxBookNo();

	ArrayList<TimeTable> getTimeTables(String wantDate);

	int isAvailableTime(String wantDateTime);
	
	ArrayList<BookingHairs> selectBookingHairsByBookingNo(int bookNo);
	
	int updateBookingStaus(Booking booking);
		
	/////페이징
	int countBookingById(String id);
	
	int countStatus1(String id);
	
	int countStatus0(String id);
	
	ArrayList<BookingHairs> pagingBookingHairsById(Paging paging, String id);
	
	ArrayList<Integer> selectNoBooking(String id);
	
	ArrayList<Integer> selectNoStatus0 (String id);
	
	ArrayList<Integer> selectNoStatus1 (String id);
	
	Booking pagingBookingById(Paging paging, String id, int no);
	
	Booking selectBookStatus1(Paging paging, String id, int no);

	Booking selectBookStatus0(Paging paging, String id, int no);

	ArrayList<Booking> pagingBookingListById(Paging paging, String id);


}
