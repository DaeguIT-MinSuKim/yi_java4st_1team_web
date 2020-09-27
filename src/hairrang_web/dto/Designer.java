package hairrang_web.dto;

public class Designer {

	private int deNo;
	private String deName;
	private String deNickname;
	private String deLevel;
	private String dePic;
	private String deContent;
	
	public Designer() {
	}

	public Designer(int deNo) {
		this.deNo = deNo;
	}

	public Designer(String deName, String deNickname, String deLevel, String dePic, String deContent) {
		this.deName = deName;
		this.deNickname = deNickname;
		this.deLevel = deLevel;
		this.dePic = dePic;
		this.deContent = deContent;
	}

	public Designer(int deNo, String deName, String deNickname, String deLevel, String dePic, String deContent) {
		this.deNo = deNo;
		this.deName = deName;
		this.deNickname = deNickname;
		this.deLevel = deLevel;
		this.dePic = dePic;
		this.deContent = deContent;
	}

	public int getDeNo() {
		return deNo;
	}

	public void setDeNo(int deNo) {
		this.deNo = deNo;
	}

	public String getDeName() {
		return deName;
	}

	public void setDeName(String deName) {
		this.deName = deName;
	}

	public String getDeNickname() {
		return deNickname;
	}

	public void setDeNickname(String deNickname) {
		this.deNickname = deNickname;
	}

	public String getDeLevel() {
		return deLevel;
	}

	public void setDeLevel(String deLevel) {
		this.deLevel = deLevel;
	}

	public String getDePic() {
		return dePic;
	}

	public void setDePic(String dePic) {
		this.dePic = dePic;
	}

	public String getDeContent() {
		return deContent;
	}

	public void setDeContent(String deContent) {
		this.deContent = deContent;
	}

	@Override
	public String toString() {
		return "Designer [deNo=" + deNo + ", deName=" + deName + ", deNickname=" + deNickname + ", deLevel=" + deLevel
				+ ", dePic=" + dePic + ", deContent=" + deContent + "]";
	}

	@Override
	public boolean equals(Object obj) {
		return this.deNo == ((Designer) obj).deNo;
	}
	
}
