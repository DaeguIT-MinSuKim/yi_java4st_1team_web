package hairrang_web.dao;

import java.util.ArrayList;

import hairrang_web.dto.Event;
import hairrang_web.utils.Paging;

public interface EventDao {

	//게시판에서 보여줄 이벤트. 생일쿠폰 제외
	ArrayList<Event> selectEventAllForBoard();
	
	//찐이벤트
	ArrayList<Event> selectEventAll();
	
	Event selectEventByNo(Event event);
	
	
	//eventDetail밑에 이전글 다음글 정보 불러오기
	Event selectEventDownSide(Event event);
	Event selectEventUpSide(Event event);
	
	//admin paging
	int countEvent(Paging paging, String status);
	ArrayList<Event> PagingEventAll(Paging paging, String status);
	
	
	//
	int selectMaxEventNo();

	

}


