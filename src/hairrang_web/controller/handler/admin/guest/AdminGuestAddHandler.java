package hairrang_web.controller.handler.admin.guest;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.service.GuestService;

public class AdminGuestAddHandler implements Command {
	private GuestService service = new GuestService();
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if (request.getMethod().equalsIgnoreCase("GET")) {
			 System.out.println("get");
			 return "guest/guest_add_form.jsp";
		} else {
			System.out.println("post");
			
			HttpSession session = request.getSession();
			
			String guestId = request.getParameter("id");
			String guestPwd = request.getParameter("pwd");
			String guestName = request.getParameter("name");
			LocalDate guestBirthday = LocalDate.parse(request.getParameter("birth"));
			String guestPhone = request.getParameter("phone");
			String guestEmail = request.getParameter("email");
			String guestGender = request.getParameter("gender");
			String infoYn = request.getParameter("infoCheck");
			if(infoYn == null) {
				infoYn = "n";
			}
			
			Guest g = new Guest();
			g.setGuestId(guestId);
			g.setGuestPwd(guestPwd);
			g.setGuestName(guestName);
			g.setGuestBirthday(guestBirthday);
			g.setGuestPhone(guestPhone);
			g.setGuestEmail(guestEmail);
			g.setGuestGender(Integer.parseInt(guestGender)); //2여자 1남자
			g.setInfoYn(infoYn); 
			
			System.out.println(g);
			session.setAttribute("name", request.getParameter("name"));
			int res = service.insertGuest(g);
			System.out.println(res);

			response.sendRedirect("guestList.do");
		}
		return null;
	}

}
