package hairrang_web.dao;

import java.util.ArrayList;

import hairrang_web.dto.Guest;

public interface GuestDao {

	ArrayList<Guest> selectGuestAll();
	
	Guest selectGuestById(Guest guest);
	
	int insertGuest(Guest guest);
	
	int updateGuest(Guest guest);
	
	int deleteGuest(Guest guest);
}
