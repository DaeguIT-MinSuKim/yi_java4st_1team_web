package hairrang_web.service;

import java.util.ArrayList;

import hairrang_web.dao.GuestDao;
import hairrang_web.dao.impl.GuestDaoImpl;
import hairrang_web.dto.Guest;
import hairrang_web.utils.Paging;

public class GuestService{
	private GuestDao dao = GuestDaoImpl.getInstance();
	
	public ArrayList<Guest> selectGuestAll(){
		return dao.selectGuestAll();
	}
	
	public Guest selectGuestById(Guest guest) {
		return dao.selectGuestById(guest);
	}
	
	public int insertGuest(Guest guest) {
		return dao.insertGuest(guest);
	}
	
	public int updateGuestPwd(Guest guest) {
		return dao.updateGuestPwd(guest);
	}
	
	public int updateGuest(Guest guest) {
		return dao.updateGuest(guest);
	}
	
	public Guest selectGuestByIdName(Guest guest) {
		return dao.selectGuestByIdName(guest);
	}
	
	public int confirmId(String id) {
		return dao.confirmId(id);
	}
	
	public Guest findId(String name, String email) {
		return dao.findId(name, email);
	}

	public Guest findPwd(String id, String name, String email) {
		return dao.findPwd(id, name, email);
	}
	
	public int updateDelYn(Guest guest) {
		return dao.updateGuestDelYn(guest);
	}
	public ArrayList<Guest> pagingGuestByAll(Paging paging){
		return dao.pagingGuestByAll(paging);
	}
	
	public int countGuest() {
		return dao.countGuest();
	}
	
	public ArrayList<Guest> searchGuestByName(Paging paging, String name){
		return dao.searchGuestByName(paging, name);
	}
	
	public ArrayList<Guest> searchGuestById(Paging paging,String id){
		return dao.searchGuestById(paging, id);
	}
	
	public ArrayList<Guest> searchGuestByPhone(Paging paging, String phone){
		return dao.searchGuestByPhone(paging, phone);
	}
	
	public int countIdSearch(String id) {
		return dao.countIdSearch(id);
	}
	
	public int countNameSearch(String name) {
		return dao.countNameSearch(name);
	}
	
	public int countPhoneSearch(String phone) {
		return dao.countPhoneSearch(phone);
	}
}	

