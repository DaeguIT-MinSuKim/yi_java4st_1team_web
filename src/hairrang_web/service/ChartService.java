package hairrang_web.service;

import org.json.JSONArray;

import hairrang_web.dao.ChartDao;
import hairrang_web.dao.impl.ChartDaoImpl;

public class ChartService {
	private ChartDao dao = ChartDaoImpl.getInstance();

	public JSONArray selectOnlyQnA() {
		return dao.QnAByoneDay();
	}
	
	public JSONArray QnAByRes() {
		return dao.QnAByRes();
	}

	public JSONArray joinGuestByOneDay() {
		return dao.joinGuestByOneDay();
	}

	public JSONArray gender() {
		return dao.gender();
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

	public JSONArray ordersByDay() {
		return dao.ordersByDay();
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
