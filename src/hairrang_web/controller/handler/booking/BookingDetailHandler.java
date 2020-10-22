package hairrang_web.controller.handler.booking;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Booking;
import hairrang_web.dto.Guest;
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
		
		/* 로그인 여부 체크  */
		HttpSession session = request.getSession();
		Guest loginUser = (Guest) session.getAttribute("loginUser");
		System.out.println("loginUser: " + loginUser);
		
		if(loginUser == null) {
			request.setAttribute("msg", "로그인 후 이용해주세요.");
		}
		
		// 체크 후
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("BookingDetailHandler >> GET");
			
			int no = Integer.parseInt(request.getParameter("no"));
			Booking booking = new Booking(no);
			System.out.println("파라미터 no: " + no);
			
			// 해당 세션 로그인 정보의 예약 사항인지 체크 후 예약 정보 가져오기.
			int res = service.checkUser(booking, loginUser);
			System.out.println("로그인 유저랑 일치하는지 체크: " + res);
			
			if(res == 0) {
				request.setAttribute("errorCode", -1);
				request.setAttribute("msg", "잘못된 접근입니다.");
				
				return "index.do";
			}
			
			
			// 아이디 체크 후 예약 정보 가져와 set
			Booking findBook = service.getBookingByBookingNo(booking);
			request.setAttribute("booking", findBook);
			
		} else {
			System.out.println("BookingDetailHandler >> POST");
			
		}
		
		return "booking/booking_detail.jsp";
	}

}
