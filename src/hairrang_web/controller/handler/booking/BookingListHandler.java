package hairrang_web.controller.handler.booking;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Booking;
import hairrang_web.service.BookingService;

public class BookingListHandler implements Command {

	private BookingService service;
	
	public BookingListHandler() {
		service = new BookingService();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("BookingListHandler >> GET");

			// Test를 위해 잠시 get 방식으로 접근 (원래는 post)
			
			// 세션으로부터 아이디 얻어오기
			// test용
			String loginUser = "test";
			List<Booking> bookingList = service.getBookingByGuestId(loginUser);
			request.setAttribute("bookingList", bookingList);
			
		} else {
			System.out.println("BookingListHandler >> POST");
			
		}
		
		return "booking/booking_list.jsp";
	}

}
