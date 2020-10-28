package hairrang_web.dto;

public class OrderDetail {

	private int odNo;
	private Hair hair;
	private int odPrice;
	private int odQuantity;
	private Coupon coupon;
	private int odDiscount;
	
	public OrderDetail() {
	}

	public OrderDetail(int odNo) {
		super();
		this.odNo = odNo;
	}

	public OrderDetail(int odNo, Hair hair, int odPrice, int odQuantity, Coupon coupon, int odDiscount) {
		this.odNo = odNo;
		this.hair = hair;
		this.odPrice = odPrice;
		this.odQuantity = odQuantity;
		this.coupon = coupon;
		this.odDiscount = odDiscount;
	}

	public int getOdNo() {
		return odNo;
	}

	public void setOdNo(int odNo) {
		this.odNo = odNo;
	}

	public Hair getHair() {
		return hair;
	}

	public void setHair(Hair hair) {
		this.hair = hair;
	}

	public int getOdPrice() {
		return odPrice;
	}

	public void setOdPrice(int odPrice) {
		this.odPrice = odPrice;
	}

	public int getOdQuantity() {
		return odQuantity;
	}

	public void setOdQuantity(int odQuantity) {
		this.odQuantity = odQuantity;
	}

	public Coupon getCoupon() {
		return coupon;
	}

	public void setCoupon(Coupon coupon) {
		this.coupon = coupon;
	}

	public int getOdDiscount() {
		return odDiscount;
	}

	public void setOdDiscount(int odDiscount) {
		this.odDiscount = odDiscount;
	}

	@Override
	public String toString() {
		String hairStr = null;
		String couponStr = null;
		
		if(hair != null) {
			hairStr = String.format("{%s}", hair.getHairNo());
			//, hair.getHairName()
		}
		
		if(coupon != null) {
			couponStr = String.format("{%d}", coupon.getCouponId());
			//, coupon.getGuest().getGuestId(), coupon.getEvent(), coupon.getUsedYn()
		}
		
		return String.format("OrderDetail [hair=%s, odPrice=%s, odQuantity=%s, coupon=%s, odDiscount=%s]",
				hairStr, odPrice, odQuantity, couponStr, odDiscount);
	}
	
	
}
