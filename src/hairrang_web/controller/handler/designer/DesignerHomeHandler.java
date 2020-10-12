package hairrang_web.controller.handler.designer;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Designer;
import hairrang_web.service.DesignerService;

public class DesignerHomeHandler implements Command {
	private DesignerService service = new DesignerService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "designer/designerHome.jsp";
		
		//디자이너 리스트 불러옴
		List<Designer> list = service.getDesignerList();
		request.setAttribute("list", list);
		return url;
	}

}
