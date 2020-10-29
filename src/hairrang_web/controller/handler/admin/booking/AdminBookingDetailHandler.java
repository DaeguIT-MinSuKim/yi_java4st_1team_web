package hairrang_web.controller.handler.admin.booking;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Booking;
import hairrang_web.dto.BookingHairs;
import hairrang_web.service.BookingService;

public class AdminBookingDetailHandler implements Command {
	BookingService service;
	
	public AdminBookingDetailHandler() {
		service = new BookingService();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		String url = "/admin/booking/booking_detail.jsp";
		
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println(getClass().getSimpleName() + ">> GET");
			
			int no = Integer.parseInt(request.getParameter("no"));
			Booking booking = service.getBookingByBookingNo(new Booking(no));
			request.setAttribute("booking", booking);
			
			//헤어리스트 가격 합계
			int sum= 0;
			for(BookingHairs hairs:booking.getHairList()) {
				sum += hairs.getHair().getHairPrice() * hairs.getQuantity();
			}
			request.setAttribute("price", sum);
			
			
		} else {
			System.out.println(getClass().getSimpleName() + ">> POST");
			
		}

		return url;
	}
	
}
