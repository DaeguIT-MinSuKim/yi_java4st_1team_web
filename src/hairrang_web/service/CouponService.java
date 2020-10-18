package hairrang_web.service;

import java.util.ArrayList;

import hairrang_web.dao.CouponDao;
import hairrang_web.dao.impl.CouponDaoImpl;
import hairrang_web.dto.Coupon;
import hairrang_web.utils.Paging;

public class CouponService {
	private CouponDao dao = CouponDaoImpl.getInstance();
	
	public ArrayList<Coupon> selectCouponById(String id){
		return dao.selectCouponById(id);
	}
	
	public ArrayList<Coupon> pagingCouponById(Paging paging, String id){
		return dao.pagingCouponById(paging, id);
	}
	
	public int countCouponById(String id) {
		return dao.countCouponById(id);
	}
}
