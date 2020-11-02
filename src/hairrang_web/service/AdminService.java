package hairrang_web.service;

import java.util.ArrayList;

import hairrang_web.dao.AdminDao;
import hairrang_web.dao.impl.AdminDaoImpl;
import hairrang_web.dto.Admin;

public class AdminService {

	private AdminDao dao = AdminDaoImpl.getInstance();
	
	public ArrayList<Admin> getAdminList() {
		return dao.selectAdminAll();
	}
	
	public Admin getAdminInfoById(Admin admin) {
		return dao.selectAdminById(admin);
	}
	
	public int createAdminAccount(Admin admin) {
		return dao.insertAdmin(admin);
	}
	
	public int modifyAdminAccount(Admin admin) {
		return dao.updateAdminName(admin);
	}
	
	public int modifyAdminAccountOnlyPwd(Admin admin) {
		return dao.updateAdminPwd(admin);
	}
	
	public int deleteAdminAccount(Admin admin) {
		return dao.deleteAdmin(admin);
	}
	
	public int checkPwd(String id, String pwd) {
		return dao.checkPwd(id, pwd);
	}
}
