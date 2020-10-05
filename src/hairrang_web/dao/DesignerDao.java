package hairrang_web.dao;

import java.util.ArrayList;

import hairrang_web.dto.Designer;

public interface DesignerDao {

	ArrayList<Designer> selectDesignerAll();
	
	Designer selectDesignerByNo(Designer de);
	
	int insertDesigner(Designer de);
	
	int updateDesigner(Designer de);
	
	int deleteDesigner(Designer de);
	
}
