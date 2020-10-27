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
	private String qnaResYn;
	private int qnaRefNo;
	private String qnaDelYn;
	private String qnaPassword;
	private String qnaSecret;
	private String qnaNotice;

	public QnA() {
		super();
		// TODO Auto-generated constructor stub
	}

	//고객 write할때
	public QnA(Guest guestId, String qnaTitle, String qnaContent, String qnaFile) {
		super();
		this.guestId = guestId;
		this.qnaTitle = qnaTitle;
		this.qnaContent = qnaContent;
		this.qnaFile = qnaFile;
	}

	//운영자 write할때
	public QnA(Admin adminId, String qnaTitle, String qnaContent, String qnaFile) {
		super();
		this.adminId = adminId;
		this.qnaTitle = qnaTitle;
		this.qnaContent = qnaContent;
		this.qnaFile = qnaFile;
	}

	public QnA(int qnaNo, Guest guestId, Admin adminId, String qnaTitle, String qnaContent, String qnaFile,
			LocalDateTime qnaRegDate, String qnaResYn, int qnaRefNo, String qnaDelYn, String qnaPassword,
			String qnaSecret) {
		super();
		this.qnaNo = qnaNo;
		this.guestId = guestId;
		this.adminId = adminId;
		this.qnaTitle = qnaTitle;
		this.qnaContent = qnaContent;
		this.qnaFile = qnaFile;
		this.qnaRegDate = qnaRegDate;
		this.qnaResYn = qnaResYn;
		this.qnaRefNo = qnaRefNo;
		this.qnaDelYn = qnaDelYn;
		this.qnaPassword = qnaPassword;
		this.qnaSecret = qnaSecret;
	}

	@Override
	public String toString() {
		return "QnA [qnaNo=" + qnaNo + ", guestId=" + guestId + ", adminId=" + adminId + ", qnaTitle=" + qnaTitle
				+ ", qnaContent=" + qnaContent + ", qnaFile=" + qnaFile + ", qnaRegDate=" + qnaRegDate + ", qnaResYn="
				+ qnaResYn + ", qnaRefNo=" + qnaRefNo + ", qnaDelYn=" + qnaDelYn + ", qnaPassword=" + qnaPassword
				+ ", qnaSecret=" + qnaSecret + "]";
	}

	public String getQnaNotice() {
		return qnaNotice;
	}

	public void setQnaNotice(String qnaNotice) {
		this.qnaNotice = qnaNotice;
	}

	public String getQnaPassword() {
		return qnaPassword;
	}

	public void setQnaPassword(String qnaPassword) {
		this.qnaPassword = qnaPassword;
	}

	public String getQnaSecret() {
		return qnaSecret;
	}

	public void setQnaSecret(String qnaSecret) {
		this.qnaSecret = qnaSecret;
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

	public String getQnaResYn() {
		return qnaResYn;
	}

	public void setQnaResYn(String qnaResYn) {
		this.qnaResYn = qnaResYn;
	}

	public int getQnaRefNo() {
		return qnaRefNo;
	}

	public void setQnaRefNo(int qnaRefNo) {
		this.qnaRefNo = qnaRefNo;
	}

	public String getQnaDelYn() {
		return qnaDelYn;
	}

	public void setQnaDelYn(String qnaDelYn) {
		this.qnaDelYn = qnaDelYn;
	}

	public QnA(Guest guestId, String qnaTitle, String qnaContent) {
		super();
		this.guestId = guestId;
		this.qnaTitle = qnaTitle;
		this.qnaContent = qnaContent;
	}

	public QnA(int qnaNo) {
		super();
		this.qnaNo = qnaNo;
	}

	public QnA(int qnaNo, String qnaTitle, String qnaContent) {
		super();
		this.qnaNo = qnaNo;
		this.qnaTitle = qnaTitle;
		this.qnaContent = qnaContent;
	}

}
