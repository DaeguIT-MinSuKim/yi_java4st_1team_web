package hairrang_web.service;

import java.util.ArrayList;

import hairrang_web.dao.CouponDao;
import hairrang_web.dao.impl.CouponDaoImpl;
import hairrang_web.dto.Coupon;
import hairrang_web.utils.Paging;

public class CouponService {
	private CouponDao dao = CouponDaoImpl.getInstance();
	
	public ArrayList<Coupon> pagingCouponByAll(Paging paging){
		return dao.pagingCouponByAll(paging);
	}
	
	public int countCoupon() {
		return dao.countCoupon();
	}
	
	public int insertJoinCoupon(String id) {
		return dao.insertJoinCoupon(id);
	}

	
	public ArrayList<Coupon> pagingCouponByEventNo(Paging paging, String no, String status) {
		return dao.pagingCouponByEventNo(paging, no, status);
	}
	
	public int countCoupon(Paging paging, String eventNo, String status) {
		return dao.countCoupon(paging, eventNo, status);
	}
	
	public ArrayList<Coupon> selectCouponById(String id){
		return dao.selectCouponById(id);
	}
	
	public ArrayList<Coupon> getAvailableCouponListToday(String id) {
		return dao.selectAvailableCouponToday(id);
	}
	
	public ArrayList<Coupon> pagingCouponById(Paging paging, String id){
		return dao.pagingCouponById(paging, id);
	}
	
	public int countCouponById(String id) {
		return dao.countCouponById(id);
	}
	
	
	

}
