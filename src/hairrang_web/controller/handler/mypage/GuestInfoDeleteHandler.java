package hairrang_web.controller.handler.mypage;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.service.GuestService;

public class GuestInfoDeleteHandler implements Command{
	private GuestService service = new GuestService();
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		HttpSession session = request.getSession();
		Guest loginUser = (Guest) session.getAttribute("loginUser");

		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("get");
			return "mypage/pwd_confirm.jsp";
		} else {
			System.out.println("post");
			int res = service.updateDelYn(new Guest(loginUser.getGuestId()));
			System.out.println("변경결과: " +res);
			
			return "mypage/guest_delete_confirm.jsp";
		}
	}
}
