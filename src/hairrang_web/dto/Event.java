package hairrang_web.dto;

import java.time.LocalDate;

public class Event {

	private int eventNo;
	private String eventName;
	private double eventSaleRate;
	private LocalDate eventStart;
	private LocalDate eventEnd;
	private String eventPic;
	private String eventContent;
	private String eventUseYn;
	
	public Event() {
	}

	public Event(int eventNo) {
		this.eventNo = eventNo;
	}
	
	public Event(String eventName, double eventSaleRate, LocalDate eventStart, LocalDate eventEnd, String eventPic,
			String eventContent, String eventUseYn) {
		this.eventName = eventName;
		this.eventSaleRate = eventSaleRate;
		this.eventStart = eventStart;
		this.eventEnd = eventEnd;
		this.eventPic = eventPic;
		this.eventContent = eventContent;
		this.eventUseYn = eventUseYn;
	}

	public Event(int eventNo, String eventName, double eventSaleRate, LocalDate eventStart, LocalDate eventEnd,
			String eventPic, String eventContent, String eventUseYn) {
		this.eventNo = eventNo;
		this.eventName = eventName;
		this.eventSaleRate = eventSaleRate;
		this.eventStart = eventStart;
		this.eventEnd = eventEnd;
		this.eventPic = eventPic;
		this.eventContent = eventContent;
		this.eventUseYn = eventUseYn;
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

	public String getEventPic() {
		return eventPic;
	}

	public void setEventPic(String eventPic) {
		this.eventPic = eventPic;
	}

	public String getEventContent() {
		return eventContent;
	}

	public void setEventContent(String eventContent) {
		this.eventContent = eventContent;
	}

	public String getEventUseYn() {
		return eventUseYn;
	}

	public void setEventUseYn(String eventUseYn) {
		this.eventUseYn = eventUseYn;
	}

	@Override
	public String toString() {
		return String.format(
				"Event [eventNo=%s, eventName=%s, eventSaleRate=%s, eventStart=%s, eventEnd=%s, eventPic=%s, eventContent=%s, eventUseYn=%s]",
				eventNo, eventName, eventSaleRate, eventStart, eventEnd, eventPic, eventContent, eventUseYn);
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
