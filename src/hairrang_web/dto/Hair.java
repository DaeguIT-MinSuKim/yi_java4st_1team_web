package hairrang_web.dto;

public class Hair {

	private int hairNo;
	private String hairName;
	private int hairPrice;
	private String pic;
	private String content;
	private int kindNo;
	
	public Hair() {
	}

	public Hair(int hairNo) {
		this.hairNo = hairNo;
	}

	public Hair(String hairName, int hairPrice, String pic, String content, int kindNo) {
		super();
		this.hairName = hairName;
		this.hairPrice = hairPrice;
		this.pic = pic;
		this.content = content;
		this.kindNo = kindNo;
	}

	public Hair(int hairNo, String hairName, int hairPrice, String pic, String content, int kindNo) {
		this.hairNo = hairNo;
		this.hairName = hairName;
		this.hairPrice = hairPrice;
		this.pic = pic;
		this.content = content;
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

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getKindNo() {
		return kindNo;
	}

	public void setKindNo(int kindNo) {
		this.kindNo = kindNo;
	}

	@Override
	public String toString() {
		return "Hair [hairNo=" + hairNo + ", hairName=" + hairName + ", hairPrice=" + hairPrice + ", pic=" + pic
				+ ", content=" + content + ", kindNo=" + kindNo + "]";
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
