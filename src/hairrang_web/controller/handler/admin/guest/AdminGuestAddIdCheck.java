package hairrang_web.controller.handler.admin.guest;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.service.GuestService;

public class AdminGuestAddIdCheck implements Command{
private GuestService service = new GuestService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if (request.getMethod().equalsIgnoreCase("GET")) {
			 System.out.println("get");
			 return "guest/id_check.jsp";
			 
		}else {
			System.out.println("post");
			String id = request.getParameter("id").trim();
			int message = service.confirmId(id);
			System.out.println(message);
			
			request.setAttribute("message", message);
			request.setAttribute("id", id);
			
			
			 return "guest/id_check.jsp";
		}
	}
}
