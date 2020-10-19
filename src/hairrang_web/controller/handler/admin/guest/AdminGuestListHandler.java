package hairrang_web.controller.handler.admin.guest;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;

public class AdminGuestListHandler implements Command {
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		String url = "/admin/guest/guest_list.jsp";
		
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println(getClass().getSimpleName() + ">> GET");
			
		} else {
			System.out.println(getClass().getSimpleName() + ">> POST");
			
		}
		
		return url;
	}

}
