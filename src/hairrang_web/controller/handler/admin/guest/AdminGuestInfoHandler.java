package hairrang_web.controller.handler.admin.guest;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.service.GuestService;

public class AdminGuestInfoHandler implements Command {
	private GuestService service = new GuestService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String id = request.getParameter("id");

		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("get");
			Guest guest = service.selectGuestById(new Guest(id));
			request.setAttribute("guest", guest);
			
			return "guest/guest_info_form.jsp";
			
		} else {
			System.out.println("post");
			
			
			String name = request.getParameter("name");
			LocalDate birth = LocalDate.parse(request.getParameter("birth"));
			String phone = request.getParameter("phone");
			String gender = request.getParameter("gender");
			String email = request.getParameter("email");
			String note = request.getParameter("note");
			String delYn = request.getParameter("delYn");
			String infoYn = request.getParameter("infoYn");
			
			
			Guest guest = service.selectGuestById(new Guest(id));
			System.out.println(guest);
			
			guest.setGuestName(name);
			guest.setGuestBirthday(birth);
			guest.setGuestPhone(phone);
			guest.setGuestGender(Integer.parseInt(gender));
			guest.setGuestEmail(email);
			guest.setGuestNote(note);
			guest.setDelYn(delYn);

			if(delYn == "y") {
				delYn = "y";
			} else {
				delYn = "n";
			}

			if(infoYn != "y") {
				infoYn = "n";
			}
			guest.setInfoYn(infoYn);

			
			int res = service.updateGuest(guest);
			System.out.println("수정결과: " + res);
			System.out.println("변경" + guest);
			
			request.setAttribute("id", guest.getGuestId());
			request.setAttribute("name", guest.getGuestName());
			request.setAttribute("birth", guest.getGuestBirthday());
			request.setAttribute("phone", guest.getGuestPhone());
			request.setAttribute("gender", guest.getGuestGender());
			request.setAttribute("email", guest.getGuestEmail());
			request.setAttribute("note", guest.getGuestNote());
			request.setAttribute("delYn", guest.getDelYn());
			request.setAttribute("infoYn", guest.getInfoYn());
			
			response.sendRedirect("guestList.do");
		}
		return null;
	}
}
