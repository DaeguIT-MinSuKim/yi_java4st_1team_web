package hairrang_web.controller.handler.admin.booking;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Booking;
import hairrang_web.dto.Guest;
import hairrang_web.service.BookingCancelSendEmail;
import hairrang_web.service.BookingService;

public class AdminBookingStatusChangeHandler implements Command {

	private BookingService bService;
	
	public AdminBookingStatusChangeHandler() {
		bService = new BookingService();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println(getClass().getSimpleName() + ">> GET");
			
			String no = request.getParameter("no");
			int res = -1;
			if (no != null) {
				res = bService.updateBookingStatus(new Booking(Integer.parseInt(no)));
				
				Booking upBooking = bService.getBookingByBookingNo(new Booking(Integer.parseInt(no)));
				Guest guest = upBooking.getGuest();
				
				try {
					BookingCancelSendEmail emailThr = new BookingCancelSendEmail();
					emailThr.setGuest(guest);
					emailThr.setBooking(upBooking);
					
					Thread t = new Thread(emailThr);
					t.start();
				} catch (Exception e) {
					throw new RuntimeException();
				}
			}
			
			response.setCharacterEncoding("UTF-8");
			response.setStatus(HttpServletResponse.SC_ACCEPTED);
				  
			PrintWriter pw = response.getWriter();
			pw.print(res); // getParameter에서 에러 res -1, 수정 실패 0, 성공 1
			pw.flush();
			
		} else {
			System.out.println(getClass().getSimpleName() + ">> POST");
			
			String[] list = request.getParameterValues("list[]");
			System.out.println(Arrays.toString(list));
			
			int res = bService.updateBookingStatus(list);
			
			response.setCharacterEncoding("UTF-8");
			response.setStatus(HttpServletResponse.SC_ACCEPTED);
				  
			PrintWriter pw = response.getWriter();
			pw.print(res); // 수정 실패 0, 성공 1
			pw.flush();
			
		}
		return null;
	}

}
