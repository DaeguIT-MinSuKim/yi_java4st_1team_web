package hairrang_web.controller.handler.booking;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Booking;
import hairrang_web.service.BookingService;

public class BookingRegisterHandler implements Command {

private BookingService service;
	
	public BookingRegisterHandler() {
		service = new BookingService();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("BookingListHandler >> GET");

			// 세션으로부터 아이디 얻어오기 (회원만 접근 가능)
			// test용
			String loginUser = "test";
			if(loginUser != null) {
				// test용으로 loginUser request에 set
				request.setAttribute("loginUser", loginUser);
				return "booking/booking_register.jsp";
			} else {
				// 경고 후 로그인 화면으로 안내
			}
			
		} else {
			System.out.println("BookingListHandler >> POST");
			
			
		}
		
		return "booking/booking_list.jsp";
	}
}
