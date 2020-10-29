package hairrang_web.service;

import java.util.ArrayList;

import hairrang_web.dao.EventDao;
import hairrang_web.dao.impl.EventDaoImpl;
import hairrang_web.dto.Event;
import hairrang_web.utils.Paging;

public class EventService {
	EventDao dao = EventDaoImpl.getInstance();
	
	public ArrayList<Event> selectEventAll(){
		return dao.selectEventAll();
	}
	
	public Event selectEventByNo(Event event) {
		return dao.selectEventByNo(event);
	}
	public ArrayList<Event> selectEventSide(Event event){
		ArrayList<Event> list = new ArrayList<Event>();
		list.add(dao.selectEventDownSide(event));
		list.add(dao.selectEventUpSide(event));
		return list;
	}
	
	public int countEvent() {
		return dao.countEvent();
	}
	
	public ArrayList<Event> PagingEventAll(Paging paging){
		return dao.PagingEventAll(paging);
	}
}
