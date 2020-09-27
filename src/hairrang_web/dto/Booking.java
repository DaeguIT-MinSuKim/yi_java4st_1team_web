package hairrang_web.dto;

import java.time.LocalDateTime;

public class Booking {

	private int bookNo;
	private Guest guest;
	private LocalDateTime bookTime;
	private Hair hair;
	private Designer designer;
	private LocalDateTime bookRegDate;
	private String bookStatus;
	private String bookNote;
	
	public Booking() {
	}

	public Booking(int bookNo) {
		this.bookNo = bookNo;
	}

	public Booking(Guest guest, LocalDateTime bookTime, Hair hair, Designer designer, String bookNote) {
		this.guest = guest;
		this.bookTime = bookTime;
		this.hair = hair;
		this.designer = designer;
		this.bookNote = bookNote;
	}

	public Booking(int bookNo, Guest guest, LocalDateTime bookTime, Hair hair, Designer designer,
			LocalDateTime bookRegDate, String bookStatus, String bookNote) {
		this.bookNo = bookNo;
		this.guest = guest;
		this.bookTime = bookTime;
		this.hair = hair;
		this.designer = designer;
		this.bookRegDate = bookRegDate;
		this.bookStatus = bookStatus;
		this.bookNote = bookNote;
	}

	public int getBookNo() {
		return bookNo;
	}

	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
	}

	public Guest getGuest() {
		return guest;
	}

	public void setGuest(Guest guest) {
		this.guest = guest;
	}

	public LocalDateTime getBookTime() {
		return bookTime;
	}

	public void setBookTime(LocalDateTime bookTime) {
		this.bookTime = bookTime;
	}

	public Hair getHair() {
		return hair;
	}

	public void setHair(Hair hair) {
		this.hair = hair;
	}

	public Designer getDesigner() {
		return designer;
	}

	public void setDesigner(Designer designer) {
		this.designer = designer;
	}

	public LocalDateTime getBookRegDate() {
		return bookRegDate;
	}

	public void setBookRegDate(LocalDateTime bookRegDate) {
		this.bookRegDate = bookRegDate;
	}

	public String getBookStatus() {
		return bookStatus;
	}

	public void setBookStatus(String bookStatus) {
		this.bookStatus = bookStatus;
	}

	public String getBookNote() {
		return bookNote;
	}

	public void setBookNote(String bookNote) {
		this.bookNote = bookNote;
	}
	
	@Override
	public String toString() {
		return "Booking [bookNo=" + bookNo + ", guest=" + guest + ", bookTime=" + bookTime + ", hair=" + hair
				+ ", designer=" + designer + ", bookRegDate=" + bookRegDate + ", bookStatus=" + bookStatus
				+ ", bookNote=" + bookNote + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + bookNo;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		return this.bookNo == ((Booking) obj).bookNo;
	}
	
}
