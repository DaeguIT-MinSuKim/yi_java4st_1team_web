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
			System.out.println(id);
			return "guest/guest_list.jsp";
		}else {
			System.out.println("post");
			String id = request.getParameter("id");
			System.out.println(id);
			
			int res = service.updateDelYn(new Guest(id));
			
			System.out.println("업뎃햇나:" + id);
			System.out.println(id);
			System.out.println("처리결과:" + res);
			
			return "guest/guest_list.jsp";
		}
	}
	

}
