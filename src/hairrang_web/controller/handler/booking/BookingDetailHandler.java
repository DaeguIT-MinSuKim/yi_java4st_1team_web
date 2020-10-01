package hairrang_web.controller.handler.booking;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Booking;
import hairrang_web.service.BookingService;

/**
 * 예약정보 상세 보기 핸들러
 * @author jisu25
 * 
 */
public class BookingDetailHandler implements Command {

	private BookingService service;
	
	public BookingDetailHandler() {
		service = new BookingService();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("BookingDetailHandler >> GET");
			
			/*
			 * 세션으로부터 아이디 얻어서, 해당 아이디의 예약 사항인지 체크 후 예약 정보 가져오기.
			 */
			
			int no = Integer.parseInt(request.getParameter("no"));
			Booking booking = new Booking(no);
			System.out.println("파라미터 no: " + no);
			System.out.println(booking);
			
			Booking findBook = service.getBookingByBookingNo(booking);
			request.setAttribute("booking", findBook);
			
		} else {
			System.out.println("BookingDetailHandler >> POST");
			
			request.setAttribute("msg", "잘못된 접근입니다.");
		}
		
		return "booking/booking_detail.jsp";
	}

}
