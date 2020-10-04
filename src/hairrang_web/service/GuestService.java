package hairrang_web.service;

import java.util.ArrayList;

import hairrang_web.dao.GuestDao;
import hairrang_web.dao.impl.GuestDaoImpl;
import hairrang_web.dto.Guest;

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
	
}
