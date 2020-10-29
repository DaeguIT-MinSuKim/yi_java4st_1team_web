package hairrang_web.controller.handler.booking;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import hairrang_web.controller.Command;
import hairrang_web.dto.Booking;
import hairrang_web.dto.Guest;
import hairrang_web.service.BookingService;
import hairrang_web.utils.GsonLocalDateTime;

/**
 * 예약 등록 핸들러
 * @author jisu25
 * BookingRegisterFormHandler -> 작성 후 submit -> BookingRegisterHandler
 */
public class BookingRegisterHandler implements Command {

	private BookingService service;
	
	public BookingRegisterHandler() {
		service = new BookingService();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("BookingRegisterHandler >> GET");

			// get방식으로 접근 불가능(직접 주소창에 입력해 접근한 경우).
			// 예약창을 이용해달라는 메시지 띄우는 처리 필요.
			
			return "booking/booking_register.jsp";
		} else {
			System.out.println("BookingRegisterHandler >> POST");
			/*
			// 파라미터 값 확인
			for (Entry<String, String[]> map : request.getParameterMap().entrySet() ) {
					System.out.println(map.getKey() + " : " + map.getValue());
			} */
						
			GsonBuilder builder = GsonLocalDateTime.getLocalDateTimeParsing("yyyy-MM-dd HH:mm");
			Gson gson = builder.create();
			
			Booking newBooking = gson.fromJson(new InputStreamReader(request.getInputStream(), "UTF-8"), Booking.class);
			newBooking.setGuest((Guest) request.getSession().getAttribute("loginUser"));
			
			int bookNo = -1;
			int deNo = newBooking.getDesigner().getDeNo();
			
			// 사용자가 html, script를 수정해 접근할 수도 있으므로 DB단에서 한번 더 검증
			if (newBooking.getBookDate().toLocalDate().isAfter(LocalDate.now())) {
				if (service.isAvailableTime(newBooking.getBookDateStr(), deNo) != 1) {
					bookNo = service.insertBookingWithHairList(newBooking);
					System.out.println("예약 완료" + newBooking);
				}
			}
			
			response.setCharacterEncoding("UTF-8");
			response.setStatus(HttpServletResponse.SC_ACCEPTED);
			
			PrintWriter pw = response.getWriter();
			pw.print(bookNo); // 이미 예약된 시간이면 -1, 그 외에 insert에 문제가 있으면 0, 성공적으로 insert 됐으면 nextNo 반환
			pw.flush();
			
			return null;
		}
	}
}
