package hairrang_web.dto;

import java.time.LocalDateTime;

public class QnA {
	private int qnaNo;
	private Guest guestId;
	private Admin adminId;
	private String qnaTitle;
	private String qnaContent;
	private String qnaFile;
	private LocalDateTime qnaRegDate;
	private String qnaResyn;
	private int qnaRefno;
	private String qnaDelyn;

	public QnA() {
		super();
		// TODO Auto-generated constructor stub
	}

	public QnA(int qnaNo, Guest guestId, Admin adminId, String qnaTitle, String qnaContent, String qnaFile,
			LocalDateTime qnaRegDate, String qnaResyn, int qnaRefno, String qnaDelyn) {
		super();
		this.qnaNo = qnaNo;
		this.guestId = guestId;
		this.adminId = adminId;
		this.qnaTitle = qnaTitle;
		this.qnaContent = qnaContent;
		this.qnaFile = qnaFile;
		this.qnaRegDate = qnaRegDate;
		this.qnaResyn = qnaResyn;
		this.qnaRefno = qnaRefno;
		this.qnaDelyn = qnaDelyn;
	}

	@Override
	public String toString() {
		return "QnA [qnaNo=" + qnaNo + ", guestId=" + guestId + ", adminId=" + adminId + ", qnaTitle=" + qnaTitle
				+ ", qnaContent=" + qnaContent + ", qnaFile=" + qnaFile + ", qnaRegDate=" + qnaRegDate + ", qnaResyn="
				+ qnaResyn + ", qnaRefno=" + qnaRefno + ", qnaDelyn=" + qnaDelyn + "]";
	}

	public int getQnaNo() {
		return qnaNo;
	}

	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}

	public Guest getGuestId() {
		return guestId;
	}

	public void setGuestId(Guest guestId) {
		this.guestId = guestId;
	}

	public Admin getAdminId() {
		return adminId;
	}

	public void setAdminId(Admin adminId) {
		this.adminId = adminId;
	}

	public String getQnaTitle() {
		return qnaTitle;
	}

	public void setQnaTitle(String qnaTitle) {
		this.qnaTitle = qnaTitle;
	}

	public String getQnaContent() {
		return qnaContent;
	}

	public void setQnaContent(String qnaContent) {
		this.qnaContent = qnaContent;
	}

	public String getQnaFile() {
		return qnaFile;
	}

	public void setQnaFile(String qnaFile) {
		this.qnaFile = qnaFile;
	}

	public LocalDateTime getQnaRegDate() {
		return qnaRegDate;
	}

	public void setQnaRegDate(LocalDateTime qnaRegDate) {
		this.qnaRegDate = qnaRegDate;
	}

	public String getQnaResyn() {
		return qnaResyn;
	}

	public void setQnaResyn(String qnaResyn) {
		this.qnaResyn = qnaResyn;
	}

	public int getQnaRefno() {
		return qnaRefno;
	}

	public void setQnaRefno(int qnaRefno) {
		this.qnaRefno = qnaRefno;
	}

	public String getQnaDelyn() {
		return qnaDelyn;
	}

	public void setQnaDelyn(String qnaDelyn) {
		this.qnaDelyn = qnaDelyn;
	}

}
