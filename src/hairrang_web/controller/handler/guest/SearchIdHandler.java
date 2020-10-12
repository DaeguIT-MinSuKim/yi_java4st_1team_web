package hairrang_web.controller.handler.guest;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.service.GuestService;

public class SearchIdHandler implements Command {
	private GuestService service = new GuestService();
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("get");
			return "member/idSearch.jsp";
		}else {
			System.out.println("post");
			String id_name = request.getParameter("id_name").trim();
			String id_email = request.getParameter("id_email").trim();
			Guest findId = service.findId(id_name, id_email);
			System.out.println(findId);
			
			if(findId==null) {
				request.setAttribute("message", -1);
			}else {
				request.setAttribute("id", findId.getGuestId());
			}
			
			return "member/idSearch_result.jsp";
			
		}	
		
	}

}
