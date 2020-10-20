package hairrang_web.controller.handler.mypage;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Booking;
import hairrang_web.dto.BookingHairs;
import hairrang_web.dto.Guest;
import hairrang_web.service.BookingService;

public class GuestBookDetailHandler implements Command {
	private BookingService bService = new BookingService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if (request.getMethod().equalsIgnoreCase("GET")) {
			HttpSession session = request.getSession();
			Guest loginUser = (Guest) session.getAttribute("loginUser");
			
			int bookNo = Integer.parseInt(request.getParameter("bookNo"));
			Booking selBooking = bService.getBookingByBookingNo(new Booking(bookNo));
			
			int sum= 0;
			for(BookingHairs hairs:selBooking.getHairList()) {
				sum += hairs.getHair().getHairPrice() * hairs.getQuantity();
			}
			
			request.setAttribute("booking", selBooking);
			request.setAttribute("price", sum);
			request.setAttribute("bookNo", bookNo);
			
			return "mypage/guest_book_detail.jsp";
			
		}else {
			return "mypage/guest_book_detail.jsp";
		}	
	}

}
