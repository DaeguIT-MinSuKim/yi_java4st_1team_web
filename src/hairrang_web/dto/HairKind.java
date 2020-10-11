package hairrang_web.dto;

import java.util.ArrayList;

public class HairKind {

	private int kindNo;
	private String kindName;
	
	private ArrayList<Hair> hairList;
	
	public ArrayList<Hair> getHairList() {
		return hairList;
	}
	
	public void setHairList(ArrayList<Hair> hairList) {
		this.hairList = hairList;
	}

	public HairKind() {
	}
	
	public HairKind(int kindNo) {
		this.kindNo = kindNo;
	}

	public HairKind(String kindName) {
		this.kindName = kindName;
	}
	
	public HairKind(int kindNo, String kindName) {
		this.kindNo = kindNo;
		this.kindName = kindName;
	}

	public int getKindNo() {
		return kindNo;
	}

	public void setKindNo(int kindNo) {
		this.kindNo = kindNo;
	}

	public String getKindName() {
		return kindName;
	}

	public void setKindName(String kindName) {
		this.kindName = kindName;
	}

	@Override
	public String toString() {
		return "HairKind [kindNo=" + kindNo + ", kindName=" + kindName + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((kindName == null) ? 0 : kindName.hashCode());
		result = prime * result + kindNo;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		return this.kindNo == ((HairKind) obj).kindNo;
	}
	
	
}
