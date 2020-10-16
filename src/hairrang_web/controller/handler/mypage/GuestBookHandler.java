package hairrang_web.controller.handler.mypage;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Booking;
import hairrang_web.dto.Guest;
import hairrang_web.service.BookingService;
import hairrang_web.service.HairService;

public class GuestBookHandler implements Command {
	private BookingService bookingService = new BookingService();
	private HairService hairService = new HairService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Guest loginUser = (Guest) session.getAttribute("loginUser");
	
		ArrayList<Booking> bookList = bookingService.getBookingByGuestId(loginUser.getGuestId());
		request.setAttribute("bookList", bookList);

		return "mypage/guest_book.jsp";
	}

}
