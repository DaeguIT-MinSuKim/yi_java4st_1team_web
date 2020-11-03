package hairrang_web.controller.handler.mypage;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
				response.setContentType("text/html; charset=UTF-8;");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('잘못된 접근입니다');location.href='guestBook.do';</script>");
				out.flush();
				return null;
		}else {
			System.out.println("post");
			
			int bookNo = Integer.parseInt(request.getParameter("bookNo"));
			
			HttpSession session = request.getSession();
			Guest loginUser = (Guest) session.getAttribute("loginUser");
			
			int resCheck = service.checkUser(new Booking(bookNo), loginUser);
			if(resCheck != 1) {
				response.setContentType("text/html; charset=UTF-8;");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('잘못된 접근입니다');location.href='guestBook.do';</script>");
				out.flush();
				return null;
			}
			
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
				
				response.setContentType("text/html; charset=UTF-8;");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('예약을 취소했습니다.');location.href='guestBook.do';</script>");
				out.flush();
			} else {
				response.setContentType("text/html; charset=UTF-8;");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('예약 취소 시도 중 실패했습니다.');location.go(-1)';</script>");
				out.flush();
				return null;
			}
			
			
		}
		
		return null;
	}

}
