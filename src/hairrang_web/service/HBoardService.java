package hairrang_web.service;

import java.util.ArrayList;

import hairrang_web.dao.HboardDao;
import hairrang_web.dao.impl.HBoardDaoImpl;
import hairrang_web.dto.HBoard;
import hairrang_web.dto.HBoardCate;

public class HBoardService {
	HboardDao dao = HBoardDaoImpl.getInstance();
	
	public ArrayList<HBoard> selectHboardByAll(){
		return dao.selectHboardByAll();
	}
	
	public HBoardCate selectHBoardByCateNo(int no){
		return dao.selectHBoardByCateNo(no);
	}
	
	public ArrayList<Integer> cateNoList(){
		return dao.cateNoList();
	}
}
