package hairrang_web.service;

import org.json.JSONArray;

import hairrang_web.dao.ChartDao;
import hairrang_web.dao.impl.ChartDaoImpl;

public class ChartService {
	private ChartDao dao = ChartDaoImpl.getInstance();

	public JSONArray qnaByoneDay(String year, String month) {
		return dao.qnaByoneDay(year,month);
	}
	
	public JSONArray QnAByRes(String year) {
		return dao.qnaByRes(year);
	}
	
	public JSONArray QnABySecret(String year) {
		return dao.qnaBySecret(year);
	}

	public JSONArray joinGuestByOneDay(String startDate, String endDate) {
		return dao.guestByJoin(startDate,endDate);
	}

	public JSONArray gender(String year) {
		return dao.guestByGender(year);
	}
	 
	public JSONArray guestIncrease(String startDate, String endDate) {
		return dao.guestIncrease(startDate, endDate);
	}

	public JSONArray bookingByTime() {
		return dao.bookingByTime();
	}

	public JSONArray bookingByDay() {
		return dao.bookingByDay();
	}

	public JSONArray bookginByDe() {
		return dao.bookginByDe();
	}

	public JSONArray bookingByHair() {
		return dao.bookingByHair();
	}

	public JSONArray ordersByDe() {
		return dao.ordersByDe();
	}

	public JSONArray ordersByDay(String year, String month) {
		return dao.ordersByDay(year,month);
	}

	public JSONArray orderDetailByevent() {
		return dao.orderDetailByevent();
	}

	public JSONArray orderDetailByHair() {
		return dao.orderDetailByHair();
	}

	public JSONArray DesignerBylevel() {
		return dao.DesignerBylevel();
	}

}
