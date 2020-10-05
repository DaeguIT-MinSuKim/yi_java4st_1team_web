package hairrang_web.dto;

public class Hair {

	private int hairNo;
	private String hairName;
	private int hairPrice;
	private String hairPic;
	private String hairContent;
	private int kindNo;
	
	public Hair() {
	}

	public Hair(int hairNo) {
		this.hairNo = hairNo;
	}

	public Hair(String hairName, int hairPrice, String hairPic, String hairContent, int kindNo) {
		super();
		this.hairName = hairName;
		this.hairPrice = hairPrice;
		this.hairPic = hairPic;
		this.hairContent = hairContent;
		this.kindNo = kindNo;
	}

	public Hair(int hairNo, String hairName, int hairPrice, String hairPic, String hairContent, int kindNo) {
		this.hairNo = hairNo;
		this.hairName = hairName;
		this.hairPrice = hairPrice;
		this.hairPic = hairPic;
		this.hairContent = hairContent;
		this.kindNo = kindNo;
	}

	public int getHairNo() {
		return hairNo;
	}

	public void setHairNo(int hairNo) {
		this.hairNo = hairNo;
	}

	public String getHairName() {
		return hairName;
	}

	public void setHairName(String hairName) {
		this.hairName = hairName;
	}

	public int getHairPrice() {
		return hairPrice;
	}

	public void setHairPrice(int hairPrice) {
		this.hairPrice = hairPrice;
	}

	public String getHairPic() {
		return hairPic;
	}

	public void setHairPic(String hairPic) {
		this.hairPic = hairPic;
	}

	public String getHairContent() {
		return hairContent;
	}

	public void setHairContent(String hairContent) {
		this.hairContent = hairContent;
	}

	public int getKindNo() {
		return kindNo;
	}

	public void setKindNo(int kindNo) {
		this.kindNo = kindNo;
	}

	@Override
	public String toString() {
		return "Hair [hairNo=" + hairNo + ", hairName=" + hairName + ", hairPrice=" + hairPrice + ", hairPic=" + hairPic
				+ ", hairContent=" + hairContent + ", kindNo=" + kindNo + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + hairNo;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		return this.hairNo == ((Hair) obj).hairNo;
	}

	
}
