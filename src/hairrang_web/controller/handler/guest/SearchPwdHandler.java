package hairrang_web.controller.handler.guest;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.controller.mail.SendMail;
import hairrang_web.dto.Guest;
import hairrang_web.service.BookingRegisterSendEmail;
import hairrang_web.service.GuestFindPwdSendEmail;
import hairrang_web.service.GuestService;

public class SearchPwdHandler implements Command {
	private GuestService service = new GuestService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("get");
			return "member/pwdSearch.jsp";
		}else {
			System.out.println("post");
			String id = request.getParameter("id").trim();
			String name  = request.getParameter("name").trim();
			String email = request.getParameter("email").trim();
			
			Guest findUser = service.findPwd(id, name, email);
			System.out.println(findUser);
			
			if(findUser == null) {
				request.setAttribute("message", -1);
			} else {
				try {
					GuestFindPwdSendEmail emailThr = new GuestFindPwdSendEmail();
					emailThr.setFindUser(findUser);
					Thread t = new Thread(emailThr);
					t.start();
				} catch (Exception e) {
					request.setAttribute("error", "비밀번호 찾기 서비스에 오류가 발생했습니다. 다시 시도해주세요.");
				}
				request.setAttribute("name", findUser.getGuestName());
			}
			return "member/pwdSearch_result.jsp";
		}
	}
	
	
	
}
