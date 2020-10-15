package hairrang_web.controller.handler.guest;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.controller.mail.SendMail;
import hairrang_web.dto.Guest;
import hairrang_web.service.GuestService;

public class SearchPwdHandler implements Command {
	private GuestService service = new GuestService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("get");
			return "member/pwdSearch.jsp";
		}else {
			System.out.println("post");
			String id = request.getParameter("id").trim();
			String name  = request.getParameter("name").trim();
			String email = request.getParameter("email").trim();
			
			Guest findUser = service.findPwd(id, name, email);
			System.out.println(findUser);
			
			if(findUser == null) {
				request.setAttribute("message", -1);
			} else {
				
				//존재하면 임시비밀번호 전송
				String key = createKey();
				
				String from = "official.hairrang@gmail.com"; //  보내는 사람
				String to = findUser.getGuestEmail().trim();// 받는 사람
				System.out.println(to);
				String cc = ""; // 참조
				String subject = "[hairrang] 임시 비밀번호 발급 안내";// 제목
				String content = "안녕하세요. \n";
				content += "고객님의 임시 비밀번호는 \n";
				content += key + " 입니다. \n";
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
				request.setAttribute("name", findUser.getGuestName());
			}
			return "member/pwdSearch_result.jsp";
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
