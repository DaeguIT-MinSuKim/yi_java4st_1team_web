package hairrang_web.dao;

import java.util.ArrayList;

import hairrang_web.dto.Event;

public interface EventDao {

	ArrayList<Event> selectEventAll();
	
	Event selectEventByNo(Event event);
	
	int insertEvent(Event event);
	
	int updateEvent(Event event);
	
	int deleteEvent(Event event);
	
	
}
