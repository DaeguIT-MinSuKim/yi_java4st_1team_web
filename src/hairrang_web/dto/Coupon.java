package hairrang_web.dto;

public class Coupon {
	private int couponId;
	private Guest guest;
	private Event event; // eventNo, eventStart, eventEnd, 
	private String usedYn;
	
	
	public Coupon() {}

	public Coupon(int couponId, Guest guest, Event event, String usedYn) {
		this.couponId = couponId;
		this.guest = guest;
		this.event = event;
		this.usedYn = usedYn;
	}

	public int getCouponId() {
		return couponId;
	}
	public void setCouponId(int couponId) {
		this.couponId = couponId;
	}
	public Guest getGuest() {
		return guest;
	}
	public void setGuest(Guest guest) {
		this.guest = guest;
	}
	public Event getEvent() {
		return event;
	}
	public void setEvent(Event event) {
		this.event = event;
	}
	public String getUsedYn() {
		return usedYn;
	}
	public void setUsedYn(String usedYn) {
		this.usedYn = usedYn;
	}
	@Override
	public String toString() {
		return String.format("Coupon [couponId=%s, guest=%s, event=%s, usedYn=%s]", couponId, guest, event, usedYn);
	}
	
	
	
	
}
