package hairrang_web.controller.handler.mypage;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Booking;
import hairrang_web.dto.Guest;
import hairrang_web.service.BookingCancelSendEmail;
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
			
			int bookNo = Integer.parseInt(request.getParameter("bookNo"));
			int res = service.updateBookingStatus(new Booking(bookNo));
			
			if(res==1) {
				Booking booking = service.getBookingByBookingNo(new Booking(bookNo));
				Guest guest = booking.getGuest();
				
				try {
					BookingCancelSendEmail emailThr = new BookingCancelSendEmail();
					emailThr.setGuest(guest);
					emailThr.setBooking(booking);
					
					Thread t = new Thread(emailThr);
					t.start();
				} catch (Exception e) {
					throw new RuntimeException();
				}
			}
			
			System.out.println(res);
			
			return "guestBook.do";
		}
		return null;
	}

}
