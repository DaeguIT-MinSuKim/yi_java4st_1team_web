package hairrang_web.controller.handler.admin.guest;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.service.GuestService;

public class AdminGuestDataHandler implements Command {
	private GuestService service = new GuestService();
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("get");
			
			String id = request.getParameter("id");
			System.out.println("id: "+id);
			Guest guest = service.selectGuestById(new Guest(id));
			request.setAttribute("guest", guest);
			
			return "guest/guest_data_form.jsp";
		}else {
			System.out.println("post");
			return "guest/guest_data_form.jsp";
		}
	}

}
