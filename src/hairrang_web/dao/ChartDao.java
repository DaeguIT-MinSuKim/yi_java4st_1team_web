package hairrang_web.dao;

import org.json.JSONArray;

public interface ChartDao {

	/*Q&A*/
	//날짜 문의 갯수(공지x)
	JSONArray QnAByoneDay();
	//답변 문의 갯수
	JSONArray QnAByRes();
	
	//날짜기준으로 가입한사람의수
	JSONArray joinGuestByOneDay();
	
	//남자여자성별 비율
	JSONArray gender();
	
	//시간별에약 
	JSONArray bookingByTime();
	
	//날짜별예약
	JSONArray bookingByDay();
	
	//디자이너별 예약 
	JSONArray bookginByDe();
	
	//헤어별 예약
	JSONArray bookingByHair();
	
	//디자이너별 주문
	JSONArray ordersByDe();
	
	//날짜별 주문
	JSONArray ordersByDay();
	
	//이벤트별 주문상세
	JSONArray orderDetailByevent();
	
	//헤어별 주문상세
	JSONArray orderDetailByHair();
	
	//직위별 디자이너
	JSONArray DesignerBylevel();
	
	
	
}
