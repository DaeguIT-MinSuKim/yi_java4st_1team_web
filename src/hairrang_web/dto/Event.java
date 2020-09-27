package hairrang_web.dto;

import java.time.LocalDate;

public class Event {

	private int eventNo;
	private String eventName;
	private double eventSaleRate;
	private LocalDate eventStart;
	private LocalDate eventEnd;
	private String pic;
	private String eventContet;
	
	public Event() {
	}

	public Event(int eventNo) {
		this.eventNo = eventNo;
	}
	
	public Event(String eventName, double eventSaleRate, LocalDate eventStart, LocalDate eventEnd, String pic,
			String eventContet) {
		this.eventName = eventName;
		this.eventSaleRate = eventSaleRate;
		this.eventStart = eventStart;
		this.eventEnd = eventEnd;
		this.pic = pic;
		this.eventContet = eventContet;
	}

	public Event(int eventNo, String eventName, double eventSaleRate, LocalDate eventStart, LocalDate eventEnd,
			String pic, String eventContet) {
		this.eventNo = eventNo;
		this.eventName = eventName;
		this.eventSaleRate = eventSaleRate;
		this.eventStart = eventStart;
		this.eventEnd = eventEnd;
		this.pic = pic;
		this.eventContet = eventContet;
	}

	public int getEventNo() {
		return eventNo;
	}

	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}

	public String getEventName() {
		return eventName;
	}

	public void setEventName(String eventName) {
		this.eventName = eventName;
	}

	public double getEventSaleRate() {
		return eventSaleRate;
	}

	public void setEventSaleRate(double eventSaleRate) {
		this.eventSaleRate = eventSaleRate;
	}

	public LocalDate getEventStart() {
		return eventStart;
	}

	public void setEventStart(LocalDate eventStart) {
		this.eventStart = eventStart;
	}

	public LocalDate getEventEnd() {
		return eventEnd;
	}

	public void setEventEnd(LocalDate eventEnd) {
		this.eventEnd = eventEnd;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public String getEventContet() {
		return eventContet;
	}

	public void setEventContet(String eventContet) {
		this.eventContet = eventContet;
	}

	@Override
	public String toString() {
		return "Event [eventNo=" + eventNo + ", eventName=" + eventName + ", eventSaleRate=" + eventSaleRate
				+ ", eventStart=" + eventStart + ", eventEnd=" + eventEnd + ", pic=" + pic + ", eventContet="
				+ eventContet + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + eventNo;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		return this.eventNo == ((Event) obj).eventNo;
	}
	
	
}
