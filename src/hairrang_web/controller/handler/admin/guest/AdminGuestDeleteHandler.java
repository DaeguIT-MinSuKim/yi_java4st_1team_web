package hairrang_web.controller.handler.admin.guest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

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
			System.out.println(guest);
			int res = service.updateDelYn(guest);
			
			
			String[] array = request.getParameterValues("array[]");
			System.out.println(array);
			
			
			request.setAttribute("guest",guest.getGuestId());
			return "guest/guest_list.jsp";
		
		}else {
			System.out.println("post");
			
			//이렇게 써야한단다 ㅅㅂ
			String[] array = request.getParameterValues("string[]");
			System.out.println(Arrays.toString(array));
			
			for(String id:array) {
				int res = service.updateDelYn(new Guest(id));
				System.out.println(res);
			}
			
			
			
			return "guest/guest_list.jsp";
		}

		
	}


}
