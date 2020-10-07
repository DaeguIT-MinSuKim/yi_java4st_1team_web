package hairrang_web.controller.handler.guest;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.service.GuestService;

public class IdCheckHandler implements Command {
	private GuestService service = new GuestService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if (request.getMethod().equalsIgnoreCase("GET")) {
			 System.out.println("get");
			 return "member/idcheck.jsp";
			 
		}else {
			System.out.println("post");
			String id = request.getParameter("id").trim();
			int message = service.confirmId(id);
			System.out.println(message);
			
			request.setAttribute("message", message);
			request.setAttribute("id", id);
			
			
			return "member/idcheck.jsp";
		}
	}
}
