package hairrang_web.dao;

import java.util.ArrayList;

import hairrang_web.dto.Coupon;
import hairrang_web.utils.Paging;

public interface CouponDao {
	
	// 쿠폰 id를 통해 해당 쿠폰 1개의 정보 조회
	// orderDetail에서 사용된 쿠폰 정보 조회하려고.
	Coupon selectCouponByCouponId(Coupon coupon);
	
	// 한 회원이 갖고 있는 쿠폰 리스트
	ArrayList<Coupon> selectCouponById(String id);
	
	// 한 회원이 갖고 있는 쿠폰 리스트 + 페이징
	ArrayList<Coupon> pagingCouponById(Paging paging, String id);
	
	// 한 회원이 갖고 있는 쿠폰 갯수
	int countCouponById(String id);

	// 오늘 기준 해당 회원이 사용할 수 있는 쿠폰 리스트 조회
	ArrayList<Coupon> selectAvailableCouponToday(String id);
}	
