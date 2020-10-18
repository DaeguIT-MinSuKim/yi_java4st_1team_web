package hairrang_web.dao;

import java.util.ArrayList;

import hairrang_web.dto.Coupon;
import hairrang_web.utils.Paging;

public interface CouponDao {
	ArrayList<Coupon> selectCouponById(String id);
	
	ArrayList<Coupon> pagingCouponById(Paging paging, String id);
	
	int countCouponById(String id);
}	
