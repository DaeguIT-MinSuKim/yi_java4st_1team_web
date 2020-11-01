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
			System.out.println("delete > get");
			String id = request.getParameter("id");
			Guest guest = service.selectGuestById(new Guest(id));
			int res = service.updateDelYn(guest);
			//System.out.println("삭제결과 ->" + res);
			
			request.setAttribute("guest",guest.getGuestId());
			response.sendRedirect("guestList.do");
		
		}else {
			System.out.println("post");
			
			//checkbox 선택 -> 삭제
			//이렇게 써야한단다~~~~
			String[] array = request.getParameterValues("string[]");
			System.out.println(Arrays.toString(array));
			
			for(String id:array) {
				int res = service.updateDelYn(new Guest(id));
				System.out.println(res);
			}
			
			
			
			return "guest/guest_list.jsp";
		}
		return null;
		
	}


}
