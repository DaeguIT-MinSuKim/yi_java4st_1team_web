package hairrang_web.dto;

public class BookingHairs {
	private Hair hair;
	private int quantity;
	
	public BookingHairs() {
	}

	public BookingHairs(Hair hair, int quantity) {
		this.hair = hair;
		this.quantity = quantity;
	}

	public Hair getHair() {
		return hair;
	}

	public void setHair(Hair hair) {
		this.hair = hair;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	@Override
	public String toString() {
		return "BookingHairs [hair=" + hair + ", quantity=" + quantity + "]";
	}

}
