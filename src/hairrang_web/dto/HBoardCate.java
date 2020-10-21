package hairrang_web.dto;

import java.util.List;

public class HBoardCate {
	private int hbCateNo;
	private String hbCateName;
	private List<HBoard> hBoard;

	public HBoardCate() {
	}

	public HBoardCate(int hbCateNo, String hbCateName, List<HBoard> hBoard) {
		super();
		this.hbCateNo = hbCateNo;
		this.hbCateName = hbCateName;
		this.hBoard = hBoard;
	}

	public int getHbCateNo() {
		return hbCateNo;
	}

	public void setHbCateNo(int hbCateNo) {
		this.hbCateNo = hbCateNo;
	}

	public String getHbCateName() {
		return hbCateName;
	}

	public void setHbCateName(String hbCateName) {
		this.hbCateName = hbCateName;
	}

	public List<HBoard> gethBoard() {
		return hBoard;
	}

	public void sethBoard(List<HBoard> hBoard) {
		this.hBoard = hBoard;
	}
	
	

	@Override
	public String toString() {
		return "HBoardCate [hbCateNo=" + hbCateNo + ", hbCateName=" + hbCateName + ", hBoard=" + hBoard + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + hbCateNo;
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
		HBoardCate other = (HBoardCate) obj;
		if (hbCateNo != other.hbCateNo)
			return false;
		return true;
	}

}
