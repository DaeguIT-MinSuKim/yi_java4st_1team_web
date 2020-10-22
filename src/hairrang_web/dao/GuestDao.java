package hairrang_web.dao;

import java.util.ArrayList;

import hairrang_web.dto.Guest;
import hairrang_web.utils.Paging;

public interface GuestDao {

	ArrayList<Guest> selectGuestAll();

	Guest selectGuestById(Guest guest);

	int insertGuest(Guest guest);

	int updateGuest(Guest guest);

	int updateGuestPwd(Guest guest);
	
	int updateGuestDelYn(Guest guest);

	int deleteGuest(Guest guest);

	int checkPwd(String id, String pwd);

	Guest selectGuestByIdName(Guest guest);
	
	int confirmId(String id);
	
	Guest findId(String name, String email);

	Guest findPwd(String id, String name, String email);
	
	//admin 페이징
	ArrayList<Guest> pagingGuestByAll(Paging paging);
	int countGuest();
	
	//admin 검색 
	
	ArrayList<Guest> searchGuestById(Paging paging, String id);
	int countIdSearch(String id);

	ArrayList<Guest> searchGuestByName(Paging paging, String name);
	int countNameSearch(String name);
	
	

}
