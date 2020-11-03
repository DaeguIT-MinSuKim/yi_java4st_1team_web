package hairrang_web.controller.handler.mypage;

import java.io.IOException;
import java.io.PrintWriter;

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
			// 로그아웃 상태에서 해당 핸들러 접근 불가 처리 해놓음
			HttpSession session = request.getSession();
			Guest loginUser = (Guest) session.getAttribute("loginUser");
			
			String bookNoStr = request.getParameter("bookNo");
			
			// 파라미터 없이 직접 접근한 경우 guestBook 화면으로 리디렉션
			if(bookNoStr == null) {
				response.sendRedirect("guestBook.do");
				return null;
			}
			
			int bookNo = Integer.parseInt(request.getParameter("bookNo"));
			Booking booking = new Booking(bookNo);
			
			int res = bService.checkUser(booking, loginUser);
			
			// 해당 예약정보가 로그인 유저의 예약건이 아닌 경우 index 화면으로 리디렉션
			if(res == 0) {
				response.setContentType("text/html; charset=UTF-8;");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('잘못된 접근입니다');location.href='index.do';</script>");
				out.flush();
				return null;
			}
			
			Booking selBooking = bService.getBookingByBookingNo(new Booking(bookNo));

			if(selBooking.getBookStatus() != 1) {
				response.setContentType("text/html; charset=UTF-8;");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('잘못된 접근입니다. (취소할 수 없는 예약 상태)');location.href='index.do';</script>");
				out.flush();
				return null;
			}
			
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
