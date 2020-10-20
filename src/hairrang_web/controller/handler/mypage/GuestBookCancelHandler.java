package hairrang_web.controller.handler.mypage;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Booking;
import hairrang_web.service.BookingService;

public class GuestBookCancelHandler implements Command {
	private BookingService service = new BookingService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("get");
			
		}else {
			System.out.println("post");
			System.out.println("오나");
			int bookNo = Integer.parseInt(request.getParameter("bookNo"));
			int res = service.updateBookingStatus(new Booking(bookNo));
			System.out.println(res);
			
			response.sendRedirect("guestBook.do");
		}
		return null;
	}

}
