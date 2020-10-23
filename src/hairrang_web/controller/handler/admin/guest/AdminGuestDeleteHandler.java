package hairrang_web.controller.handler.admin.guest;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.service.GuestService;

public class AdminGuestDeleteHandler implements Command {
	private GuestService service = new GuestService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("get");
			String id = request.getParameter("id");
			Guest guest = service.selectGuestById(new Guest(id));
			//System.out.println(guest);
			request.setAttribute("guest", guest);
			
			return "guest/guest_delete_form.jsp";
		}else {
			System.out.println("post");
			
			String guest = request.getParameter("guest");
			//System.out.println("id:" + guest);
			int res = service.updateDelYn(new Guest(guest));
			//System.out.println(res);
			
			response.sendRedirect("guestList.do");
		}
		return null;
		
	}
	

}
