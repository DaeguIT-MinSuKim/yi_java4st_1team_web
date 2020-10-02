package hairrang_web.dao;

import java.util.ArrayList;

import hairrang_web.dto.Hair;
import hairrang_web.dto.HairKind;

public interface HairDao {

	ArrayList<HairKind> selectHairAll();
	
	HairKind selectHairKindByKindNo(int kindNo);
	
	Hair selectHairByNo(Hair hair);
	
	int insertHair(Hair hair);
	
	int updateHair(Hair hair);
	
	int deleteHair(Hair hair);
	
	
	
	/* 헤어종류 CRUD */
	
	int insertHairKind(HairKind kind);
	
	int updateHairKind(HairKind kind);
	
	int deleteHairKind(HairKind kind);
	
}
