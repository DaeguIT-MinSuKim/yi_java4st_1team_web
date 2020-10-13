package hairrang_web.controller.handler.guest;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.service.GuestService;

public class PwdConfirmHandler implements Command {
	private GuestService service = new GuestService();
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		HttpSession session = request.getSession();
		Guest loginUser = (Guest) session.getAttribute("loginUser");
		
		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("get");
			return "mypage/guest_pwdConfirm.jsp";
		}else {
			System.out.println("post");
			String pwd = request.getParameter("pwd").trim();
			Guest guest = service.selectGuestById(loginUser);
			System.out.println(pwd);
			System.out.println(guest);
			System.out.println(guest.getGuestPwd());
			
			if(guest.getGuestPwd().equals(pwd)) {
				request.setAttribute("id", loginUser.getGuestId());
			}else {
				request.setAttribute("message", -1);
			}
			return "mypage/guest_info_form.jsp";
		}
		
		
	}

}
