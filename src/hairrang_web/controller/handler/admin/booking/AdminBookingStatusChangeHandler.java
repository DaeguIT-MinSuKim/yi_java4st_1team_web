package hairrang_web.controller.handler.admin.booking;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.controller.mail.SendMail;
import hairrang_web.dto.Booking;
import hairrang_web.dto.BookingHairs;
import hairrang_web.dto.Guest;
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
				
				sendBookingInfoEmail(upBooking, guest);
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

	private void sendBookingInfoEmail(Booking booking, Guest guest) {
		/* 예약 완료 메일 전송 */
		String from = "official.hairrang@gmail.com"; //  보내는 사람
		String to = guest.getGuestEmail();// 받는 사람
		String cc = ""; // 참조
		String subject = "[Hairrang] 고객님의 예약이 취소되었습니다.";// 제목
		
		String content = "<table>" + 
				"	<h5>예약 정보 </h5>" + 
				"	<tr style=\"border-top:1px solid #e4e4e4;\">" + 
				"		<td>예약 번호</td><td>" + booking.getBookNo() + 
				"		</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td>예약등록일</td>" + 
				"		<td><s>" + booking.getBookRegDateStr() +
				"		</s></td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td>예약자</td><td>" + guest.getGuestName() + "(" + guest.getGuestId() + ")</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td>연락처</td><td>"+ guest.getGuestPhone() + "</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td>예약 상태</td><td>예약 취소</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td>이용 날짜</td> " + 
				"		<td><s>" + booking.getBookDateStr() +
				"		</s></td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td>담당 디자이너</td>" + 
				"		<td>"+ booking.getDesigner().getDeNickname() + "</td>" + 
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
		for(BookingHairs hairs : booking.getHairList()) {
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
