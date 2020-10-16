package hairrang_web.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Booking {
	private int rownum;
	private int bookNo;
	private Guest guest;
	private LocalDateTime bookDate;
	private Hair hair;
	private Designer designer;
	private LocalDateTime bookRegDate;
	private int bookStatus;
	private String bookNote;
	
	public Booking() {
	}

	public Booking(int bookNo) {
		this.bookNo = bookNo;
	}

	public Booking(Guest guest) {
		this.guest = guest;
	}
	
	public Booking(Guest guest, LocalDateTime bookDate, Hair hair, Designer designer, String bookNote) {
		this.guest = guest;
		this.bookDate = bookDate;
		this.hair = hair;
		this.designer = designer;
		this.bookNote = bookNote;
	}

	public Booking(int rownum, int bookNo, Guest guest, LocalDateTime bookDate, Hair hair, Designer designer,
			LocalDateTime bookRegDate, int bookStatus, String bookNote) {
		this.rownum = rownum;
		this.bookNo = bookNo;
		this.guest = guest;
		this.bookDate = bookDate;
		this.hair = hair;
		this.designer = designer;
		this.bookRegDate = bookRegDate;
		this.bookStatus = bookStatus;
		this.bookNote = bookNote;
	}
	
	

	
	public int getRownum() {
		return rownum;
	}

	public void setRownum(int rownum) {
		this.rownum = rownum;
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

	public LocalDateTime getBookDate() {
		return bookDate;
	}

	public void setBookDate(LocalDateTime bookDate) {
		this.bookDate = bookDate;
	}
	
	public void setBookDate(String bookDateStr) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		this.bookDate = LocalDateTime.parse(bookDateStr, formatter);
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

	public int getBookStatus() {
		return bookStatus;
	}

	public void setBookStatus(int bookStatus) {
		this.bookStatus = bookStatus;
	}

	public String getBookStatusStr() {
		String str = null;
		switch(bookStatus) {
			case 1: str = "예약 접수"; break;
			case 2: str = "예약 완료"; break;
			case 0: str = "예약 취소"; break;
			case 3: str = "방문 완료"; break;
			case -1: str = "미방문"; break;
		}
		return str;
	}
	
	public String getBookNote() {
		return bookNote;
	}

	public void setBookNote(String bookNote) {
		this.bookNote = bookNote;
	}

	@Override
	public boolean equals(Object obj) {
		return this.bookNo == ((Booking) obj).bookNo;
	}

	@Override
	public String toString() {
		return "Booking [rownum= " + rownum +" + bookNo=" + bookNo + ", guest=" + guest + ", bookDate=" + bookDate + ", hair=" + hair
				+ ", designer=" + designer + ", bookRegDate=" + bookRegDate + ", bookStatus=" + bookStatus
				+ ", bookNote=" + bookNote + "]";
	}
	
	
}
