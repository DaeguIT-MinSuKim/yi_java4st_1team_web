package hairrang_web.service;

import java.util.ArrayList;

import hairrang_web.dao.DesignerDao;
import hairrang_web.dao.impl.DesignerDaoImpl;
import hairrang_web.dto.Designer;

public class DesignerService {

	private DesignerDao dao = DesignerDaoImpl.getInstance();
	
	public ArrayList<Designer> getDesignerList() {
		return dao.selectDesignerAll();
	}
	
	public Designer getDesignerInfo(Designer de) {
		return dao.selectDesignerByNo(de);
	}
	
}
