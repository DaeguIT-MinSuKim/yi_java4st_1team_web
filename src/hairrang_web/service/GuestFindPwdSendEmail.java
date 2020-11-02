package hairrang_web.service;

import javax.mail.MessagingException;

import hairrang_web.controller.mail.SendMail;
import hairrang_web.dto.Guest;

public class GuestFindPwdSendEmail implements Runnable {
	
	private Guest findUser;

	private GuestService service = new GuestService();
	
	public Guest getFindUser() {
		return findUser;
	}

	public void setFindUser(Guest findUser) {
		this.findUser = findUser;
	}

	@Override
	public void run() {
		//존재하면 임시비밀번호 전송
		String key = createKey();
		
		String from = "official.hairrang@gmail.com"; //  보내는 사람
		String to = findUser.getGuestEmail().trim();// 받는 사람
		System.out.println(to);
		String cc = ""; // 참조
		String subject = "[hairrang] 임시 비밀번호 발급 안내";// 제목
		String content = "안녕하세요.<br>";
		content += "고객님의 임시 비밀번호는<br>";
		content += key + " 입니다.<br>";
		content += "로그인 후 비밀번호를 변경하세요.";

		if (from.trim().equals("")) {
			System.out.println("보내는 사람을 입력하지 않았습니다.");

		} else if (to.trim().equals("")) {
			System.out.println("받는 사람을 입력하지 않았습니다.");

		} else {
			try {
				//메일 
				SendMail sm = new SendMail();
				findUser.setGuestPwd(key);
				int res = service.updateGuestPwd(findUser);
				System.out.println("비밀번호 업데이트 결과: " + res);
				//비밀번호 변경

				sm.sendEmail(from, to, cc, subject, content);
				//메일 전송
				System.out.println("메일 전송에 성공하였습니다.");
				
				//변경확인
				System.out.println("~확인~");
				System.out.println("보낸 비밀번호->" + key);
				Guest g = service.selectGuestById(findUser);
				System.out.println(g);
				
			} catch (MessagingException me) {
				System.out.println("메일 전송에 실패하였습니다.");
				System.out.println("실패 이유 : " + me.getMessage());
			} catch (Exception e) {
				System.out.println("메일 전송에 실패하였습니다.");
				System.out.println("실패 이유 : " + e.getMessage());
			}
		}
	}
	
	public static String createKey() {
		char pwd[] = new char[] { '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'A', 'B', 'C', 'D', 'E',
				'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
				'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u',
				'v', 'w', 'x', 'y', 'z'};// 배열에 선언

		String random = "";

		for (int i = 0; i < 10; i++) {
			int selectRandomPw = (int) (Math.random() * (pwd.length));
			random += pwd[selectRandomPw];
		}
		return random;

	}

}
