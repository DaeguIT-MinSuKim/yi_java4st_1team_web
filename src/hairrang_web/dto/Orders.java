package hairrang_web.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.stream.Collectors;

public class Orders {

	private int ordersNo;
	private Guest guest;
	private Designer designer;
	private int ordersTotalPrice;
	private LocalDateTime ordersDate;
	
	private ArrayList<OrderDetail> odList;

	public Orders() {
	}
	
	public Orders(int orders_no) {
		this.ordersNo = orders_no;
	}

	public Orders(Guest guest) {
		this.guest = guest;
	}

	public Orders(int ordersNo, Guest guest, Designer designer, int ordersTotalPrice, LocalDateTime ordersDate) {
		this.ordersNo = ordersNo;
		this.guest = guest;
		this.designer = designer;
		this.ordersTotalPrice = ordersTotalPrice;
		this.ordersDate = ordersDate;
	}
	
	public Orders(int ordersNo, Guest guest, Designer designer, int ordersTotalPrice, LocalDateTime ordersDate,
			ArrayList<OrderDetail> odList) {
		this.ordersNo = ordersNo;
		this.guest = guest;
		this.designer = designer;
		this.ordersTotalPrice = ordersTotalPrice;
		this.ordersDate = ordersDate;
		this.odList = odList;
	}

	public int getOrdersNo() {
		return ordersNo;
	}

	public void setOrdersNo(int ordersNo) {
		this.ordersNo = ordersNo;
	}

	public Guest getGuest() {
		return guest;
	}

	public void setGuest(Guest guest) {
		this.guest = guest;
	}

	public Designer getDesigner() {
		return designer;
	}

	public void setDesigner(Designer designer) {
		this.designer = designer;
	}

	public int getOrdersTotalPrice() {
		return ordersTotalPrice;
	}

	public void setOrdersTotalPrice(int ordersTotalPrice) {
		this.ordersTotalPrice = ordersTotalPrice;
	}

	public LocalDateTime getOrdersDate() {
		return ordersDate;
	}

	public String getOrdersDateStr() {
		return this.ordersDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
	}
	
	public void setOrdersDate(LocalDateTime ordersDate) {
		this.ordersDate = ordersDate;
	}

	public ArrayList<OrderDetail> getOdList() {
		return odList;
	}

	public void setOdList(ArrayList<OrderDetail> odList) {
		this.odList = odList;
	}

	public String getHowManyItems() {
		if(this.odList.size() == 0) {
			return "-";
		} else if (this.odList.size() == 1) {
			return String.format("%s", odList.get(0).getHair().getHairName());
		}
		
		ArrayList<Hair> hairs = this.odList.stream().map(OrderDetail::getHair)
			.sorted(Comparator.comparing(Hair::getHairPrice).reversed())
			.collect(Collectors.toCollection(ArrayList::new));
		
		return String.format("%s 외 %d 건", hairs.get(0).getHairName(), hairs.size() - 1);
	}
	
	public String getUsedCoupon() {
		String res = null;
		if(odList != null) {
			ArrayList<Coupon> list = odList.stream().map(OrderDetail::getCoupon).collect(Collectors.toCollection(ArrayList::new));
			if (list.get(0) != null) {
				res = list.get(0).getEvent().getEventName();
			}
		}
		return res;
	}
	
	public int getDiscountAmount() {
		ArrayList<Integer> list = odList.stream().map(OrderDetail::getOdDiscount).collect(Collectors.toCollection(ArrayList::new));
		return list==null? 0 : list.get(0);
	}
	
	@Override
	public String toString() {
		return String.format(
				"Orders [ordersNo=%s, guest=%s, designer=%s, ordersTotalPrice=%s, ordersDate=%s]\n<orderList>\n%s\n",
				ordersNo, guest, designer, ordersTotalPrice, ordersDate, odList);
	}
	
	
}
