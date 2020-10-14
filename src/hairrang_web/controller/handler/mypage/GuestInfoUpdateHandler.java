package hairrang_web.controller.handler.mypage;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.service.GuestService;

public class GuestInfoUpdateHandler implements Command {
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
			
			String name = request.getParameter("name");
			LocalDate birth = LocalDate.parse(request.getParameter("birth"));
			String gender = request.getParameter("gender");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			String infoYn = request.getParameter("infoYn");
			if(infoYn == null) {
				infoYn = "n";
			}

			service.selectGuestById(new Guest(loginUser.getGuestId()));
			loginUser.setGuestName(name);
			loginUser.setGuestBirthday(birth);
			loginUser.setGuestGender(Integer.parseInt(gender));
			loginUser.setGuestEmail(email);
			loginUser.setGuestPhone(phone);
			loginUser.setInfoYn(infoYn);
			
			int res = service.updateGuest(loginUser);
			System.out.println("수정결과: " + res);
			
			request.setAttribute("id", loginUser.getGuestId());
			request.setAttribute("name", loginUser.getGuestName());
			request.setAttribute("birth", loginUser.getGuestBirthday());
			request.setAttribute("gender", loginUser.getGuestGender());
			request.setAttribute("email", loginUser.getGuestEmail());
			request.setAttribute("phone", loginUser.getGuestPhone());
			request.setAttribute("infoYn", loginUser.getInfoYn());
			
			return "mypage/guest_info_form.jsp";
		}
	}
	

}
