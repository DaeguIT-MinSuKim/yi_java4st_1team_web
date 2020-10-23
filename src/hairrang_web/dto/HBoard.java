package hairrang_web.dto;

import java.time.LocalDateTime;
import java.util.List;

public class HBoard {
	private int hbNo;
	private HBoardCate hbCate;
	private String hbTitle;
	private String hbContent;
	private String hbPic;
	private LocalDateTime hbRegDate;

	public HBoard() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	public HBoard(int hbNo, HBoardCate hbCate, String hbTitle, String hbContent, String hbPic,
			LocalDateTime hbRegDate) {
		super();
		this.hbNo = hbNo;
		this.hbCate = hbCate;
		this.hbTitle = hbTitle;
		this.hbContent = hbContent;
		this.hbPic = hbPic;
		this.hbRegDate = hbRegDate;
	}


	public int getHbNo() {
		return hbNo;
	}


	public void setHbNo(int hbNo) {
		this.hbNo = hbNo;
	}


	public HBoardCate getHbCate() {
		return hbCate;
	}


	public void setHbCate(HBoardCate hbCate) {
		this.hbCate = hbCate;
	}


	public String getHbTitle() {
		return hbTitle;
	}


	public void setHbTitle(String hbTitle) {
		this.hbTitle = hbTitle;
	}


	public String getHbContent() {
		return hbContent;
	}


	public void setHbContent(String hbContent) {
		this.hbContent = hbContent;
	}


	public String getHbPic() {
		return hbPic;
	}


	public void setHbPic(String hbPic) {
		this.hbPic = hbPic;
	}


	public LocalDateTime getHbRegDate() {
		return hbRegDate;
	}


	public void setHbRegDate(LocalDateTime hbRegDate) {
		this.hbRegDate = hbRegDate;
	}

	
	
	@Override
	public String toString() {
		return "HBoard [hbNo=" + hbNo + ", hbCate=" + hbCate + ", hbTitle=" + hbTitle + ", hbContent=" + hbContent
				+ ", hbPic=" + hbPic + ", hbRegDate=" + hbRegDate + "]";
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + hbNo;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		HBoard other = (HBoard) obj;
		if (hbNo != other.hbNo)
			return false;
		return true;
	}

}
