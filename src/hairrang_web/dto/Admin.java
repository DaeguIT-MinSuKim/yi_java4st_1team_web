package hairrang_web.dto;

public class Admin {

	private String adminId;
	private String adminPwd;
	private String adminName;
	
	private Admin() {
	}

	private Admin(String adminId) {
		this.adminId = adminId;
	}

	private Admin(String adminId, String adminPwd, String adminName) {
		super();
		this.adminId = adminId;
		this.adminPwd = adminPwd;
		this.adminName = adminName;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getAdminPwd() {
		return adminPwd;
	}

	public void setAdminPwd(String adminPwd) {
		this.adminPwd = adminPwd;
	}

	public String getAdminName() {
		return adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((adminId == null) ? 0 : adminId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		return this.adminId == ((Admin) obj).adminId;
	}

	@Override
	public String toString() {
		return "Admin [adminId=" + adminId + ", adminPwd=" + adminPwd + ", adminName=" + adminName + "]";
	}
	
}
