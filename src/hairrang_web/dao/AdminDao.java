package hairrang_web.dao;

import java.util.ArrayList;

import hairrang_web.dto.Admin;

public interface AdminDao {

	ArrayList<Admin> selectAdminAll();
	
	Admin selectAdminById(Admin admin);
	
	int insertAdmin(Admin admin);
	
	int updateAdminName(Admin admin);
	
	int updateAdminPwd(Admin admin);
	
	int deleteAdmin(Admin admin);
	
	int checkPwd(String id, String pwd);
}
