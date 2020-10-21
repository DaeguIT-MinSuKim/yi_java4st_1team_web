package hairrang_web.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class Booking {
	
	private int bookNo;
	private Guest guest;
	private LocalDateTime bookDate;
	private Designer designer;
	private LocalDateTime bookRegDate;
	private int bookStatus;
	private String bookNote;
	private int rowNum;
	
	private List<BookingHairs> hairList;
	
	public Booking() {
	}

	public Booking(int bookNo) {
		this.bookNo = bookNo;
	}

	public Booking(Guest guest) {
		this.guest = guest;
	}
	
	public Booking(Guest guest, LocalDateTime bookDate, List<BookingHairs> hairList, Designer designer, String bookNote) {
		this.guest = guest;
		this.bookDate = bookDate;
		this.hairList = hairList;
		this.designer = designer;
		this.bookNote = bookNote;
	}

	public Booking(int rowNum, int bookNo, Guest guest, LocalDateTime bookDate, Hair hair, Designer designer,
			LocalDateTime bookRegDate, int bookStatus, String bookNote) {
		this.rowNum = rowNum;
		this.bookNo = bookNo;
		this.guest = guest;
		this.bookDate = bookDate;
		this.designer = designer;
		this.bookRegDate = bookRegDate;
		this.bookStatus = bookStatus;
		this.bookNote = bookNote;
	}
	
	public Booking(int rowNum, int bookNo, Guest guest, LocalDateTime bookDate, List<BookingHairs> hairList, Designer designer,
			LocalDateTime bookRegDate, int bookStatus, String bookNote) {
		this.rowNum = rowNum;
		this.bookNo = bookNo;
		this.guest = guest;
		this.bookDate = bookDate;
		this.hairList = hairList;
		this.designer = designer;
		this.bookRegDate = bookRegDate;
		this.bookStatus = bookStatus;
		this.bookNote = bookNote;
	}
	
	public int getRowNum() {
		return rowNum;
	}

	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
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

	public String getBookDateStr() {
		return this.bookDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
	}
	
	public void setBookDate(LocalDateTime bookDate) {
		this.bookDate = bookDate;
	}
	
	public void setBookDate(String bookDateStr) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		this.bookDate = LocalDateTime.parse(bookDateStr, formatter);
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
	
	public String getBookRegDateStr() {
		 return this.bookRegDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
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
			case 1: str = "예약 완료"; break;
			case 2: str = "방문 완료"; break;
			case 0: str = "예약 취소"; break;
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

	public List<BookingHairs> getHairList() {
		return hairList;
	}

	public void setHairList(List<BookingHairs> hairList) {
		this.hairList = hairList;
	}

	public String getHowManyHairItems() {
		ArrayList<Hair> hairs = this.hairList.stream().map(BookingHairs::getHair)
			.sorted(Comparator.comparing(Hair::getHairPrice).reversed())
			.collect(Collectors.toCollection(ArrayList::new));
		
		int size = hairs.size();
		
		if (size == 1) {
			return String.format("%s", hairs.get(0).getHairName());
		}
		
		return String.format("%s 외 %d 건", hairs.get(0).getHairName(), hairs.size() - 1);
	}
	
	@Override
	public boolean equals(Object obj) {
		return this.bookNo == ((Booking) obj).bookNo;
	}

	@Override
	public String toString() {
		return String.format("Booking [bookNo=%s, guest=%s, bookDate=%s, designer=%s, hairList=%s]", bookNo, guest,
				bookDate, designer, hairList);
	}

	
	
}
