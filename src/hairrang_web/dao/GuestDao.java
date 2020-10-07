package hairrang_web.dao;

import java.util.ArrayList;

import hairrang_web.dto.Guest;

public interface GuestDao {

	ArrayList<Guest> selectGuestAll();

	Guest selectGuestById(Guest guest);

	int insertGuest(Guest guest);

	int updateGuest(Guest guest);

	int updateGuestPwd(Guest guest);

	int deleteGuest(Guest guest);

	int checkPwd(String id, String pwd);

	Guest selectGuestByIdName(Guest guest);
	
	int confirmId(String id);

}
