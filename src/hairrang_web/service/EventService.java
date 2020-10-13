package hairrang_web.service;

import java.util.ArrayList;

import hairrang_web.dao.EventDao;
import hairrang_web.dao.impl.EventDaoImpl;
import hairrang_web.dto.Event;

public class EventService {
	EventDao dao = EventDaoImpl.getInstance();
	
	public ArrayList<Event> selectEventAll(){
		return dao.selectEventAll();
	}
	
	public Event selectEventByNo(Event event) {
		return dao.selectEventByNo(event);
	}
	public ArrayList<Event> selectEventSide(Event event){
		return dao.selectEventSide(event);
	}
}
