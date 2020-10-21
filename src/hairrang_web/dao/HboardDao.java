package hairrang_web.dao;

import java.util.ArrayList;

import hairrang_web.dto.HBoard;
import hairrang_web.dto.HBoardCate;

public interface HboardDao {
	ArrayList<HBoard> selectHboardByAll();
	
	HBoardCate selectHBoardByCateNo(int no);
	
	ArrayList<Integer> cateNoList();
}
