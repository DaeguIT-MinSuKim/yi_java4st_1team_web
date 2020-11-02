package hairrang_web.service;

import org.json.JSONArray;

import hairrang_web.dao.ChartDao;
import hairrang_web.dao.impl.ChartDaoImpl;

public class ChartService {
	private ChartDao dao = ChartDaoImpl.getInstance();
	
	public JSONArray selectOnlyQnA() {
		return dao.selectOnlyQnA();
	}
}
