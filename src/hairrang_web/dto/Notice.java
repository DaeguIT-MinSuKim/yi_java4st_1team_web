package hairrang_web.dto;

import java.time.LocalDateTime;

public class Notice {
	private int noticeNo;
	private String noticeTitle;
	private String noticeContent;
	private String noticeDelYn;
	private String noticeFile;
	private LocalDateTime noticeRegDate;

	public LocalDateTime getNoticeRegDate() {
		return noticeRegDate;
	}

	public void setNoticeRegDate(LocalDateTime noticeRegDate) {
		this.noticeRegDate = noticeRegDate;
	}

	public String getNoticeFile() {
		return noticeFile;
	}

	public void setNoticeFile(String noticeFile) {
		this.noticeFile = noticeFile;
	}

	public String getNoticeDelYn() {
		return noticeDelYn;
	}

	public void setNoticeDelYn(String noticeDelYn) {
		this.noticeDelYn = noticeDelYn;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public Notice(int noticeNo, String noticeTitle, String noticeContent, String noticeDelYn, String noticeFile,
			LocalDateTime noticeRegDate) {
		super();
		this.noticeNo = noticeNo;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.noticeDelYn = noticeDelYn;
		this.noticeFile = noticeFile;
		this.noticeRegDate = noticeRegDate;
	}

	@Override
	public String toString() {
		return "Notice [noticeNo=" + noticeNo + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
				+ ", noticeDelYn=" + noticeDelYn + ", noticeFile=" + noticeFile + ", noticeRegDate=" + noticeRegDate
				+ "]";
	}

	public Notice(int noticeNo, String noticeTitle, String noticeContent, String noticeDelYn, String noticeFile) {
		super();
		this.noticeNo = noticeNo;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.noticeDelYn = noticeDelYn;
		this.noticeFile = noticeFile;
	}

	public Notice(int noticeNo, String noticeTitle, String noticeContent) {
		super();
		this.noticeNo = noticeNo;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
	}

	public Notice(String noticeTitle, String noticeContent) {
		super();
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
	}

	public Notice(int noticeNo) {
		super();
		this.noticeNo = noticeNo;
	}

}
