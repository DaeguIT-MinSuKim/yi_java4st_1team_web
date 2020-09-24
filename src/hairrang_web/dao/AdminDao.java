package hairrang_web.dao;

import java.util.ArrayList;

import hairrang_web.dto.Admin;

public interface AdminDao {

	ArrayList<Admin> selectAdminAll();
	
	Admin selectAdminById(Admin Admin);
	
	int insertAdmin(Admin Admin);
	
	int updateAdmin(Admin Admin);
	
	int deleteAdmin(Admin Admin);
	
}
