package hairrang_web.controller.handler.mypage;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.service.GuestService;

public class GuestPwdUpdateHandler implements Command{
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
			System.out.println("수정전" + loginUser.getGuestPwd());
			
			String update_pwd = request.getParameter("new_pwd");
			service.selectGuestById(new Guest(loginUser.getGuestId()));
			loginUser.setGuestPwd(update_pwd);
			service.updateGuestPwd(loginUser);
			System.out.println("수정후" + loginUser.getGuestPwd());
			
			request.setAttribute("id", loginUser.getGuestId());
			return "mypage/guest_pwd_form.jsp";
		
		}
	}

}
