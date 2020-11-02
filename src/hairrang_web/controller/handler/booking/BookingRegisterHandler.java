package hairrang_web.controller.handler.booking;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.time.LocalDate;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import hairrang_web.controller.Command;
import hairrang_web.controller.mail.SendMail;
import hairrang_web.dto.Booking;
import hairrang_web.dto.BookingHairs;
import hairrang_web.dto.Guest;
import hairrang_web.service.BookingService;
import hairrang_web.service.GuestService;
import hairrang_web.utils.GsonLocalDateTime;

/**
 * 예약 등록 핸들러
 * @author jisu25
 * BookingRegisterFormHandler -> 작성 후 submit -> BookingRegisterHandler
 */
public class BookingRegisterHandler implements Command {

	private BookingService bService;
	private GuestService gService;
	
	public BookingRegisterHandler() {
		bService = new BookingService();
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
				if (bService.isAvailableTime(newBooking.getBookDateStr(), deNo) != 1) {
					bookNo = bService.insertBookingWithHairList(newBooking);
					System.out.println("예약 완료" + newBooking);
					
					Booking insBooking = bService.getBookingByBookingNo(new Booking(bookNo));
					Guest guest = newBooking.getGuest();
					
					/* 예약 완료 메일 전송 */
					String from = "official.hairrang@gmail.com"; //  보내는 사람
					String to = guest.getGuestEmail();// 받는 사람
					String cc = ""; // 참조
					String subject = "[Hairrang] 고객님의 예약이 완료되었습니다.";// 제목
					
					String content = "<table>" + 
							"	<h5>예약 정보 </h5>" + 
							"	<tr style=\"border-top:1px solid #e4e4e4;\">" + 
							"		<td>예약 번호</td><td>" + bookNo + 
							"		</td>" + 
							"	</tr>" + 
							"	<tr>" + 
							"		<td>예약등록일</td>" + 
							"		<td>" + insBooking.getBookRegDateStr() +
							"		</td>" + 
							"	</tr>" + 
							"	<tr>" + 
							"		<td>예약자</td><td>" + guest.getGuestName() + "(" + guest.getGuestId() + ")</td>" + 
							"	</tr>" + 
							"	<tr>" + 
							"		<td>연락처</td><td>"+ guest.getGuestPhone() + "</td>" + 
							"	</tr>" + 
							"	<tr>" + 
							"		<td>예약 상태</td><td>"+ insBooking.getBookStatusStr() + "</td>" + 
							"	</tr>" + 
							"	<tr>" + 
							"		<td>이용 날짜</td> " + 
							"		<td>" + insBooking.getBookDateStr() +
							"		</td>" + 
							"	</tr>" + 
							"	<tr>" + 
							"		<td>담당 디자이너</td>" + 
							"		<td>"+ insBooking.getDesigner().getDeNickname() + "</td>" + 
							"	</tr>" + 
							"</table>" + 
							"<br><br>" + 
							"<h5>시술 정보</h5>" + 
							"<table>" + 
							"	<tr>" + 
							"		<td style=\"border-top:1px solid #e4e4e4; width:250px;\">시술 정보</td> " + 
							"		<td style=\"border-top:1px solid #e4e4e4; width:50px;\">가격</td> " + 
							"		<td style=\"border-top:1px solid #e4e4e4; width:50px;\">수량</td>" + 
							"	</tr>";
					int sum = 0;
					for(BookingHairs hairs : insBooking.getHairList()) {
						content += "<tr>"
								+ "	<td>" + hairs.getHair().getHairName() + "</td>" 
								+ "	<td>" + String.format("%,d", hairs.getHair().getHairPrice())+ "</td>"
								+ "	<td>" + hairs.getQuantity() + "</td>"
								+ "</tr>";
						sum += hairs.getHair().getHairPrice();
					}
					content += "<tr>" + 
								"<td colspan=\"3\" class=\"tright\">합계 : <b style=\"font-weight:bold\">" + String.format("%,d", sum)+ "원</b></td>" + 
								"</tr>" + 
								"</table>";

					if (to.trim().equals("")) {
						System.out.println("받는 사람을 입력하지 않았습니다.");

					} else {
						try {
							//메일 
							SendMail sm = new SendMail();
							sm.sendEmail(from, to, cc, subject, content);
							System.out.println("메일 전송에 성공하였습니다.");
						} catch (MessagingException me) {
							System.out.println("메일 전송에 실패하였습니다.");
							System.out.println("실패 이유 : " + me.getMessage());
						} catch (Exception e) {
							System.out.println("메일 전송에 실패하였습니다.");
							System.out.println("실패 이유 : " + e.getMessage());
						}
					}
					
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
