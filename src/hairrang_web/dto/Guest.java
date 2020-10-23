package hairrang_web.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Guest {

	private int guestCode;
	private String guestId;
	private String guestPwd;
	private String guestName;
	private LocalDate guestBirthday;
	private String guestPhone;
	private String guestEmail;
	private int guestGender; // 성별 숫자로 0여 1남
	private LocalDateTime guestJoinDate;
	private String guestNote;
	private String delYn;
	private String infoYn;
	
	public Guest() {
	}

	public Guest(String guestId) {
		this.guestId = guestId;
	}
	
	

	public Guest(int guestCode, String guestId) {
		this.guestCode = guestCode;
		this.guestId = guestId;
	}

	public Guest(String guestId, String guestName, LocalDate guestBirthday, String guestPhone, String guestEmail,int guestGender,
			LocalDateTime guestJoinDate, String guestNote, String delYn, String infoYn) {
		super();
		this.guestId = guestId;
		this.guestName = guestName;
		this.guestBirthday = guestBirthday;
		this.guestPhone = guestPhone;
		this.guestEmail = guestEmail;
		this.guestGender = guestGender;
		this.guestJoinDate = guestJoinDate;
		this.guestNote = guestNote;
		this.delYn = delYn;
		this.infoYn = infoYn;
	}

	public Guest(String guestId, String guestPwd, String guestName, LocalDate guestBirthday, String guestPhone, String guestEmail, int guestGender,
			String guestNote, String infoYn) {
		this.guestId = guestId;
		this.guestPwd = guestPwd;
		this.guestName = guestName;
		this.guestBirthday = guestBirthday;
		this.guestPhone = guestPhone;
		this.guestEmail = guestEmail;
		this.guestEmail = guestEmail;
		this.guestGender = guestGender;
		this.guestNote = guestNote;
		this.infoYn = infoYn;
	}

	public Guest(String guestId, String guestPwd, String guestName, LocalDate guestBirthday, String guestPhone, String guestEmail, int guestGender,
			LocalDateTime guestJoinDate, String guestNote, String delYn, String infoYn) {
		this.guestId = guestId;
		this.guestPwd = guestPwd;
		this.guestName = guestName;
		this.guestBirthday = guestBirthday;
		this.guestPhone = guestPhone;
		this.guestEmail = guestEmail;
		this.guestGender = guestGender;
		this.guestJoinDate = guestJoinDate;
		this.guestNote = guestNote;
		this.delYn = delYn;
		this.infoYn = infoYn;
	}
	
	

	public int getGuestCode() {
		return guestCode;
	}

	public void setGuestCode(int guestCode) {
		this.guestCode = guestCode;
	}

	public String getGuestId() {
		return guestId;
	}

	public void setGuestId(String guestId) {
		this.guestId = guestId;
	}

	public String getGuestPwd() {
		return guestPwd;
	}

	public void setGuestPwd(String guestPwd) {
		this.guestPwd = guestPwd;
	}

	public String getGuestName() {
		return guestName;
	}

	public void setGuestName(String guestName) {
		this.guestName = guestName;
	}

	public LocalDate getGuestBirthday() {
		return guestBirthday;
	}

	public void setGuestBirthday(LocalDate guestBirthday) {
		this.guestBirthday = guestBirthday;
	}

	public String getGuestPhone() {
		return guestPhone;
	}

	public void setGuestPhone(String guestPhone) {
		this.guestPhone = guestPhone;
	}
	
	
	public String getGuestEmail() {
		return guestEmail;
	}

	public void setGuestEmail(String guestEmail) {
		this.guestEmail = guestEmail;
	}

	public int getGuestGender() {
		return guestGender;
	}

	public void setGuestGender(int guestGender) {
		this.guestGender = guestGender;
	}

	public LocalDateTime getGuestJoinDate() {
		return guestJoinDate;
	}

	public void setGuestJoinDate(LocalDateTime guestJoinDate) {
		this.guestJoinDate = guestJoinDate;
	}

	public String getGuestNote() {
		return guestNote;
	}

	public void setGuestNote(String guestNote) {
		this.guestNote = guestNote;
	}

	public String getDelYn() {
		return delYn;
	}

	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}

	
	
	public String getInfoYn() {
		return infoYn;
	}

	public void setInfoYn(String infoYn) {
		this.infoYn = infoYn;
	}

	
	

	@Override
	public String toString() {
		return "Guest [guestId=" + guestId + ", guestPwd=" + guestPwd + ", guestName=" + guestName + ", guestBirthday="
				+ guestBirthday + ", guestPhone=" + guestPhone + ", guestEmail=" + guestEmail + ", guestGender="
				+ guestGender + ", guestJoinDate=" + guestJoinDate + ", guestNote=" + guestNote + ", delYn=" + delYn
				+ ", infoYn=" + infoYn + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((guestId == null) ? 0 : guestId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		return this.guestId == ((Guest) obj).guestId;
	}
	
}
