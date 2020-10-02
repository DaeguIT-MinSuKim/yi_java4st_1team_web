package hairrang_web.dao;

import java.util.ArrayList;

import hairrang_web.dto.Hair;

public interface HairDao {

	ArrayList<Hair> selectHairAll();
	
	Hair selectHairByNo(Hair hair);
	
	int insertHair(Hair hair);
	
	int updateHair(Hair hair);
	
	int deleteHair(Hair hair);
	
}
