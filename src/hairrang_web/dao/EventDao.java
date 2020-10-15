package hairrang_web.dao;

import java.util.ArrayList;

import hairrang_web.dto.Event;

public interface EventDao {

	ArrayList<Event> selectEventAll();
	
	Event selectEventByNo(Event event);
	
	int insertEvent(Event event);
	
	int updateEvent(Event event);
	
	int deleteEvent(Event event);
	
	//eventDetail밑에 이전글 다음글 정보 불러오기
	Event selectEventDownSide(Event event);
	
	Event selectEventUpSide(Event event);
	
	
}
