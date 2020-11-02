package hairrang_web.service;

import javax.mail.MessagingException;

import hairrang_web.controller.mail.SendMail;
import hairrang_web.dto.Booking;
import hairrang_web.dto.BookingHairs;
import hairrang_web.dto.Guest;

public class BookingRegisterSendEmail implements Runnable {
	
	private Booking insBooking;
	private Guest guest;
	
	public Booking getInsBooking() {
		return insBooking;
	}

	public void setInsBooking(Booking insBooking) {
		this.insBooking = insBooking;
	}

	public Guest getGuest() {
		return guest;
	}

	public void setGuest(Guest guest) {
		this.guest = guest;
	}

	@Override
	public void run() {
		/* 예약 완료 메일 전송 */
		String from = "official.hairrang@gmail.com"; //  보내는 사람
		String to = guest.getGuestEmail();// 받는 사람
		String cc = ""; // 참조
		String subject = "[Hairrang] 고객님의 예약이 완료되었습니다.";// 제목
		
		String content = "<table>" + 
				"	<h5>예약 정보 </h5>" + 
				"	<tr style=\"border-top:1px solid #e4e4e4;\">" + 
				"		<td>예약 번호</td><td>" + insBooking.getBookNo() + 
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
