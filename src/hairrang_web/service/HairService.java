package hairrang_web.service;

import java.util.ArrayList;

import hairrang_web.dao.HairDao;
import hairrang_web.dao.impl.HairDaoImpl;
import hairrang_web.dto.Hair;
import hairrang_web.dto.HairKind;

public class HairService {

	private HairDao dao = HairDaoImpl.getInstance();
	
	public ArrayList<HairKind> getHairListAll() {
		return dao.selectHairAll();
	};
	
	public HairKind getHairKindInfo(int kindNo) {
		return dao.selectHairKindByKindNo(kindNo);
	}
	
	public Hair getHairInfo(Hair hair) {
		return dao.selectHairByNo(hair);
	}
}
